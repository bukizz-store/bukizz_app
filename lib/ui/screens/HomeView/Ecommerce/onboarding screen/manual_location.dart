import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/buttons/Reusable_Button.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_TextForm.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/textformAddress.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/constants.dart';
import '../../../../../data/models/ecommerce/address/address_model.dart';
import '../../../../../data/providers/auth/updateUserData.dart';
import '../../../../../data/providers/school_repository.dart';

class SelectLocation extends StatefulWidget {
  static const String route = '/selectlocation';
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  TextEditingController searchcontroller = TextEditingController();
  Set<String> selectedCities = Set(); // Keep track of selected cities

  List<String> cities = [
    'New Delhi',
    'Kurukshetra',
    'Kanpur',
    'Panipath',
    'Gurugram',
    'Patna',
    'Sonipath',
    'Lucknow',
  ];

  List<String> foundedCities = [];

  @override
  void initState() {
    // TODO: implement initState
    foundedCities = cities;
    super.initState();
  }

  void _runFilter(String word){
    List<String> results = [];
    if(word.isEmpty){
      results = cities;
    }else{
      results = cities.where((element) => element.toLowerCase().contains(word.toLowerCase())).toList();
    }
    setState(() {
      foundedCities = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensions.width16),
          child: Column(
            children: [
              SizedBox(
                height: dimensions.height10 * 5.3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(
                    width: dimensions.width10 * 2,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: dimensions.height10 * 4.4,
                    child: TextField(
                      onChanged: (value) => _runFilter(value),
                      controller: searchcontroller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: dimensions.height8 * 2),
                        hintText: 'Search city',
                        hintStyle: TextStyle(color: Color(0xFF7A7A7A)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              dimensions.height10 * 4.4 / 2),
                          borderSide: BorderSide(color: Color(0xFF7A7A7A)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              dimensions.height10 * 4.4 / 2),
                          borderSide: BorderSide(color: Colors.black38),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: dimensions.height24,
              ),
              GestureDetector(
                onTap: getLocation,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensions.width10,
                        vertical: dimensions.height8 * 1.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Column(
                          children: [
                            Icon(
                              Icons.my_location,
                              color: Color(0xFF00579E),
                            ),
                          ],
                        ),
                        // SizedBox(width: dimensions.width10/2,),
                        Column(
                          children: [
                            SizedBox(
                              width: dimensions.width10 * 25.6,
                              child: const Text(
                                'Location permission not enabled',
                                style: TextStyle(
                                  color: Color(0xFF00579E),
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: dimensions.height8 / 2,
                            ),
                            SizedBox(
                              width: dimensions.height10 * 25.2,
                              child: const Text(
                                'Tap here to enable permission for a better experience',
                                style: TextStyle(
                                  color: Color(0xFF444444),
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.chevron_right)],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: dimensions.height16 / 2,
              ),
              Container(
                height: dimensions.height10 * 45,
                child: ListView.builder(
                  itemCount: foundedCities.length,
                  itemBuilder: (context, index) {
                    final city = foundedCities[index];
                    return CheckboxListTile(
                      title: Text(city),
                      value: selectedCities.contains(city),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value ?? false) {
                            selectedCities.add(city);
                          } else {
                            selectedCities.remove(city);
                          }
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: dimensions.width16 / 2,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: dimensions.height16 * 2,
              ),
              ReusableElevatedButton(
                  width: dimensions.width342,
                  height: dimensions.height10 * 5.4,
                  onPressed: () {
                    context.read<UpdateUserData>().saveLocationSetToSharedPreferences(selectedCities.toList());
                    Navigator.pushNamed(context, MainScreen.route);
                  },
                  buttonText: 'Save Locations'),
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

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // Get current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Get location details using placemark
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
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
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.route, (route) => false);
    }
  }
}
