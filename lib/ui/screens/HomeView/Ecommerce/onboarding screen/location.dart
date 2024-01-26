import 'dart:async';

import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/onboarding%20screen/manual_location.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/buttons/Reusable_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  static const route = '/locationRoute';
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String city="";
  String state="";
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dimensions.width24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: dimensions.height10*5.3,),
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
              SizedBox(height: dimensions.height10*5.3,),
              SvgPicture.asset('assets/location.svg'),
              SizedBox(height: dimensions.height10*2.5,),
              ReusableElevatedButton(
                  width: dimensions.width342,
                  height: dimensions.height10*5.4,
                  onPressed: () {
                    getLocation();
                  },
                  buttonText: 'Enable Device Loaction'
              ),
              SizedBox(height: dimensions.height10*1.6,),
              ReusableElevatedButton(
                  width: dimensions.width342,
                  height: dimensions.height10*5.4,
                  onPressed: (){
                    Navigator.pushNamed(context, SelectLocation.route);
                  },
                  buttonText: 'Enter Your Location Manually',
                  buttonColor:Color(0xFFE0EFFF),
                  textColor: Color(0xFF058FFF),
                  borderColor: Color(0xFF058FFF),
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

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      // Get current position
      Position position = await Geolocator.getCurrentPosition();

      // Get location details using placemark
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );



      setState(() {
        state = placemarks.first.administrativeArea ?? '';
        city = placemarks.first.locality ?? '';
      });

      Navigator.pushNamedAndRemoveUntil(context, MainScreen.route, (route) => false);
    }
  }
}


