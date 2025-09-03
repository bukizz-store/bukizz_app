import 'dart:async';

import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/providers/auth/updateUserData.dart';
import 'package:bukizz/data/providers/school_repository.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/manual_location.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/buttons/Reusable_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/font_family.dart';
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensions.width24),
          child: Column(
            children: [
              // Top spacing
              SizedBox(height: dimensions.height10 * 3),

              // Title text
              Text(
                'Set your location to start exploring schools near you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF121212),
                  fontSize: MediaQuery.of(context).size.width < 360 ? 18 : 20,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),

              // Flexible space for the image
              Expanded(
                flex: 3,
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: dimensions.height10 * 35,
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: SvgPicture.asset(
                        'assets/location.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom section with buttons
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // First button
                    SizedBox(
                      width: double.infinity,
                      height: dimensions.height10 * 5.4,
                      child: ReusableElevatedButton(
                        width: double.infinity,
                        height: dimensions.height10 * 5.4,
                        onPressed: getLocation,
                        buttonText: 'Enable Device Location',
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.nunito.name,
                        fontSize:
                            MediaQuery.of(context).size.width < 360 ? 15 : 17,
                      ),
                    ),

                    SizedBox(height: dimensions.height10 * 1.5),

                    // Second button
                    SizedBox(
                      width: double.infinity,
                      height: dimensions.height10 * 5.4,
                      child: ReusableElevatedButton(
                        shadowColor: Color(0xFFE0EFFF).withOpacity(0.9),
                        width: double.infinity,
                        height: dimensions.height10 * 5.4,
                        onPressed: () {
                          Navigator.pushNamed(context, SelectLocation.route);
                        },
                        buttonText: 'Enter Your Location Manually',
                        buttonColor: Color(0xFFE0EFFF),
                        textColor: Color(0xFF058FFF),
                        borderColor: Color(0xFF058FFF),
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.nunito.name,
                        fontSize:
                            MediaQuery.of(context).size.width < 360 ? 15 : 17,
                      ),
                    ),

                    // Bottom spacing
                    SizedBox(height: dimensions.height10 * 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

      AppConstants.location = placemarks.first.locality!;
      navigateToPage(address);
    }
  }

  void navigateToPage(Address address) {
    context.read<UpdateUserData>().updateUserAddress(address);

    context
        .read<SchoolDataProvider>()
        .loadData(context)
        .then((value) => debugPrint("School Data Loaded Successfully"));

    Navigator.pushNamedAndRemoveUntil(
        context, MainScreen.route, (route) => false);
  }
}
