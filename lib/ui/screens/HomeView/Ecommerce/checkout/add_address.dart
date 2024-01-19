import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_TextForm.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/textformAddress.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../../widgets/circle/custom circleAvatar.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';
import 'package:geolocator/geolocator.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController pinCodeController=TextEditingController();
  TextEditingController stateController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController buildingnameController=TextEditingController();
  TextEditingController addressController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Delivery Address'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: dimensions.height8*1.5,),

            //container with step 1 2 3
            Container(
              width: dimensions.screenWidth,
              height: dimensions.height8*11.5,
              color: Colors.white,
              child:Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensions.width24*1.5),
                child: Row(
                  children: [
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Color(0xFF058FFF),
                      borderColor: Colors.black38,
                      borderWidth: 0.10,
                      child: ReusableText(text: '1', fontSize: 16,color: Colors.white, height: null,),
                    ),
                    Container(
                      width: 90.0,
                      height: 1.0,
                      color: Color(0xFFA5A5A5),
                    ),
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Colors.transparent,
                      borderColor: Colors.black,
                      borderWidth: 0.5,
                      child: ReusableText(text: '2', fontSize: 16,color: Color(0xFF058FFF),),
                    ),
                    Container(
                      width: 90.0,
                      height: 1.0,
                      color: Color(0xFFA5A5A5),
                    ),
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Colors.transparent,
                      borderColor: Colors.black,
                      borderWidth: 0.5,
                      child: ReusableText(text: '3', fontSize: 16,color: Color(0xFF058FFF),),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: dimensions.height8*1.5,),

            Container(
              width: dimensions.screenWidth,
              height: dimensions.height8*62,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:dimensions.width24,vertical: dimensions.height8*3),
                child: Column(
                  children: [
                    CustomTextForm(
                      width: dimensions.width342,
                      height: dimensions.height8*5.5,
                      hintText: 'Full Name (Required) *',
                      controller: nameController,
                    ),
                    SizedBox(height: dimensions.height8*2,),
                    CustomTextForm(
                      width: dimensions.width342,
                      height: dimensions.height8*5.5,
                      hintText: 'Phone number (Required) *',
                      controller: phoneController,
                    ),
                    SizedBox(height: dimensions.height8*2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextForm(
                          width: dimensions.width16*9.2,
                          height: dimensions.height8*5.5,
                          hintText: 'Pin Code (Required) *',
                          controller: pinCodeController,
                        ),
                        GestureDetector(
                          onTap: onUseMyLocationTap,
                          child: Container(
                            width: dimensions.width16*9.2,
                            height: dimensions.height8*4.5,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 0.50, color: Color(0xFF00579E)),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.my_location,color: Color(0xFF00579E),),
                                ReusableText(text:  'Use my location',fontSize: 14,color: Color(0xFF00579E),fontWeight: FontWeight.w600,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: dimensions.height8*2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextForm(
                          width: dimensions.width16*9.2,
                          height: dimensions.height8*5.5,
                          hintText:  'State (Required) *',
                          controller: stateController,
                        ),
                        CustomTextForm(
                          width: dimensions.width16*9.2,
                          height: dimensions.height8*5.5,
                          hintText:  'City (Required) *',
                          controller: cityController,
                        ),
                      ],
                    ),
                    SizedBox(height: dimensions.height8*2,),
                    CustomTextForm(
                      width: dimensions.width342,
                      height: dimensions.height8*5.5,
                      hintText: 'House No., Building Name (Required) *',
                      controller: buildingnameController,
                    ),

                    SizedBox(height: dimensions.height8*2,),

                    CustomTextForm(
                      width: dimensions.width342,
                      height: dimensions.height8*5.5,
                      hintText:'Road name, Area, Colony (Required) *',
                      controller: addressController,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void onUseMyLocationTap() async {
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
        print('Location permission denied');
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
        pinCodeController.text = placemarks.first.postalCode ?? '';
        stateController.text = placemarks.first.administrativeArea ?? '';
        cityController.text = placemarks.first.locality ?? '';
        buildingnameController.text = placemarks.first.name ?? '';
        addressController.text = placemarks.first.thoroughfare ?? '';
      });
    }
  }

}

