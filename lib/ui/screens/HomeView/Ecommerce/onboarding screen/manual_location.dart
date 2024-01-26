import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/buttons/Reusable_Button.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_TextForm.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/textformAddress.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class SelectLocation extends StatefulWidget {
  static const String route = '/selectlocation';
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  TextEditingController searchcontroller=TextEditingController();
  String city="";
  String state="";
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
    'Lakshdeep',
    'Nepal',
    'California',
    'Los Angelles',
    'San Francisco',
    'Bangkok',
    'Las Vegas',
  ];
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensions.width16),
          child: Column(
            children: [
              SizedBox(height: dimensions.height10*5.3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back),
                  CustomTextForm(
                      width: dimensions.width10*29,
                      height: dimensions.height10*4.4,
                      controller: searchcontroller,
                      hintText: 'Search city',
                      icon: Icons.search,
                  ),
                ],
              ),

              SizedBox(height: dimensions.height24,),

              GestureDetector(
                onTap: getLocation,
                child: Container(
                  height: dimensions.height10*7.9,
                  width: dimensions.width10*34.8,
                  color: Colors.white,
                  child:  Padding(
                    padding: EdgeInsets.symmetric(horizontal: dimensions.width10,vertical: dimensions.height8*1.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Column(
                          children: [
                            Icon(Icons.my_location,color: Color(0xFF00579E),),
                          ],
                        ),
                        // SizedBox(width: dimensions.width10/2,),
                        Column(
                          children: [
                            SizedBox(
                              width: dimensions.width10*25.6,
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
                            SizedBox(height: dimensions.height8/2,),
                            SizedBox(
                              width: dimensions.height10*25.2,
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
                          children: [
                            Icon(Icons.chevron_right)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: dimensions.height16/2,),

              Container(
                height: dimensions.height10*45,
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final city = cities[index];
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
                      contentPadding: EdgeInsets.symmetric(horizontal: dimensions.width16/2,),
                    );
                  },
                ),
              ),

              SizedBox(height: dimensions.height16*2,),

              ReusableElevatedButton(
                  width: dimensions.width342,
                  height: dimensions.height10*5.4,
                  onPressed: (){
                    Navigator.pushNamed(context, MainScreen.route);
                  },
                  buttonText: 'Enable Device Loaction'
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
    }
  }
}
