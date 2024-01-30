import 'dart:async';

import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/data/providers/auth/updateUserData.dart';
import 'package:bukizz_1/data/providers/school_repository.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/onboarding%20screen/manual_location.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/buttons/Reusable_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../../../data/models/ecommerce/address/address_model.dart';

class LocationScreen extends StatefulWidget {
  static const route = '/locationRoute';
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: dimensions.width24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: dimensions.height10 * 5.3,
            ),
            SizedBox(
              width: dimensions.width342,
              child: const Text(
                'Set your location to start exploring schools near you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF121212),
                  fontSize: 20,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: dimensions.height10 * 2,
            ),
            SvgPicture.asset('assets/location.svg'),
            SizedBox(
              height: dimensions.height10,
            ),
            ReusableElevatedButton(
                width: dimensions.width342,
                height: dimensions.height10 * 5.4,
                onPressed: getLocation,
                buttonText: 'Enable Device Loaction'),
            SizedBox(
              height: dimensions.height10 * 1.6,
            ),
            ReusableElevatedButton(
              width: dimensions.width342,
              height: dimensions.height10 * 5.4,
              onPressed: () {

                Navigator.pushNamed(context, SelectLocation.route);
              },
              buttonText: 'Enter Your Location Manually',
              buttonColor: Color(0xFFE0EFFF),
              textColor: Color(0xFF058FFF),
              borderColor: Color(0xFF058FFF),
            ),
          ],
        ),
      ),
    ));
  }

  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are not enabled');
      return;
    } else {
      print("true");
    }

    // Check if location permission is granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // If permission is not granted, request it
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Handle case when permission is not granted by showing a message or UI
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color(0xFFE0EFFF),
              title: Text('Location Permission Denied'),
              content: Text('Please enable your location or select manually.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // print("checked");
      // Get current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Get location details using placemark
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // print(placemarks.first.toString());

      Address address = Address(
          name: AppConstants.userData.name,
          houseNo: placemarks.first.name!,
          street: placemarks.first.street!,
          city: placemarks.first.locality!,
          state: placemarks.first.administrativeArea!,
          pinCode: placemarks.first.postalCode!,
          phone: AppConstants.userData.mobile,
          email: AppConstants.userData.email);

      context.read<UpdateUserData>().updateUserAddress(address);

      context.read<SchoolDataProvider>().loadData(context);

      Navigator.pushNamedAndRemoveUntil(context, MainScreen.route, (route) => false);
    }
  }
}
