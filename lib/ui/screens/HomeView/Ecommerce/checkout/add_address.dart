

import 'package:bukizz/data/models/ecommerce/address/address_model.dart';
import 'package:bukizz/data/providers/auth/updateUserData.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_TextForm.dart';
import 'package:bukizz/widgets/text%20and%20textforms/textformAddress.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/constants.dart';
import '../../../../../data/repository/address/update_address.dart';
import '../../../../../widgets/circle/custom circleAvatar.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';
import 'package:geolocator/geolocator.dart';

class AddAddress extends StatefulWidget {
  static const String route = '/add_address';
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  bool showAlternatePhoneField = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController alternatePhoneController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController buildingnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String fullAddress = '';

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Delivery Address'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: dimensions.height8 * 1.5,
            ),
            Container(
              width: dimensions.screenWidth,
              // height: dimensions.height8 * 62,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: dimensions.width24,
                    vertical: dimensions.height8 * 3),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: dimensions.height8 * 1.5,
                      ),
                      CustomTextForm(
                        width: dimensions.width342,
                        height: dimensions.height8 * 5.5,
                        hintText: 'Full Name (Required) *',
                        labelText: 'Full Name',
                        controller: nameController,
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      CustomTextForm(
                        width: dimensions.width342,
                        height: dimensions.height8 * 5.5,
                        hintText: 'Phone number (Required) *',
                        labelText: 'Phone number',
                        controller: phoneController,
                        isPhoneNo: true,
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      CustomTextForm(
                        width: dimensions.width342,
                        height: dimensions.height8 * 5.5,
                        hintText: 'Email',
                        labelText: 'Email',
                        controller: emailController,
                        isEmail: true,
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      // GestureDetector(
                      //   onTap: onUseMyLocationTap,
                      //   child: Container(
                      //     width: dimensions.screenWidth,
                      //     height: dimensions.height8 * 5.5,
                      //     decoration: ShapeDecoration(
                      //       shape: RoundedRectangleBorder(
                      //         side: BorderSide(
                      //             width: 1, color: Color(0xFF00579E)),
                      //         borderRadius: BorderRadius.circular(100),
                      //       ),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment:
                      //       MainAxisAlignment.center,
                      //       children: [
                      //         Icon(
                      //           Icons.my_location,
                      //           color: Color(0xFF00579E),
                      //         ),
                      //         ReusableText(
                      //           text: 'Use my location',
                      //           fontSize: 14,
                      //           color: Color(0xFF00579E),
                      //           fontWeight: FontWeight.w600,
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: dimensions.height16,),
                      CustomTextForm(
                        width: dimensions.screenWidth,
                        height: dimensions.height8 * 5.5,
                        hintText: 'Pin Code (Required) *',
                        labelText: 'Pin Code',
                        controller: pinCodeController,
                        isPinCode: true,
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showAlternatePhoneField = !showAlternatePhoneField;
                          });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                  showAlternatePhoneField
                                      ? Icons.remove
                                      : Icons.add,
                                  color: Color(0xFF00579E)),
                              ReusableText(
                                text: showAlternatePhoneField
                                    ? 'Dont Add Alternate Phone'
                                    : 'Add Alternate Phone',
                                fontSize: 14,
                                color: Color(0xFF00579E),
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          ),
                        ),
                      ),
                      if (showAlternatePhoneField)
                        SizedBox(
                          height: dimensions.height8 * 2,
                        ),
                      if (showAlternatePhoneField)
                        CustomTextForm(
                          width: dimensions.width342,
                          height: dimensions.height8 * 5.5,
                          hintText: 'Alternate Phone',
                          labelText: 'Alternate Number',
                          controller: alternatePhoneController,
                          isPhoneNo: true,
                        ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextForm(
                            width: dimensions.width16 * 9.2,
                            height: dimensions.height8 * 5.5,
                            hintText: 'State (Required) *',
                            labelText: 'State (Required) *',
                            controller: stateController,
                          ),
                          CustomTextForm(
                            width: dimensions.width16 * 9.2,
                            height: dimensions.height8 * 5.5,
                            hintText: 'City (Required) *',
                            labelText: 'City',
                            controller: cityController,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      CustomTextForm(
                        width: dimensions.width342,
                        height: dimensions.height8 * 5.5,
                        hintText: 'House No., Building Name (Required) *',
                        labelText: 'House No.',
                        controller: buildingnameController,
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      CustomTextForm(
                        width: dimensions.width342,
                        height: dimensions.height8 * 5.5,
                        hintText: 'Street name, Area, Colony (Required) *',
                        labelText: 'Street',
                        controller: addressController,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          //Save Address logic here
          if(phoneController.text.length != 10 ){
            AppConstants.showSnackBarTop(context, 'Please Enter Valid Number', AppColors.error, Icons.error_outline_rounded);
            return;
          }
          if(pinCodeController.text.length !=6){
            AppConstants.showSnackBarTop(context, 'Please Enter Valid Pincode', AppColors.error, Icons.error_outline_rounded);
            return;
          }
          if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(emailController.text.toString())){
            AppConstants.showSnackBarTop(context, 'Please Enter a valid Email', AppColors.error, Icons.error_outline_rounded);
            return;
          }
          if(buildingnameController.text.isEmpty) {
              AppConstants.showSnackBarTop(context, 'Please Enter House No.', AppColors.error, Icons.error_outline_rounded);
              return;
            }
          if(addressController.text.isEmpty) {
            AppConstants.showSnackBarTop(context, 'Please Enter Street Name', AppColors.error, Icons.error_outline_rounded);
            return;
          }

          Address address = Address(name: nameController.text, houseNo: buildingnameController.text, street: fullAddress, city: cityController.text, state: stateController.text, pinCode: pinCodeController.text, phone: phoneController.text, email: emailController.text);
          context.read<UpdateUserData>().updateUserAlternateAddress(address);
          context.read<UpdateAddressRepository>().alternateAddress = address;
          Navigator.of(context).pop();
        },
        child: Container(
          height: dimensions.height8 * 9,
          width: dimensions.screenWidth,
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: dimensions.width24,
                  vertical: dimensions.height8 * 1.5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xFF058FFF),
                ),
                child: Center(
                    child: ReusableText(
                  text: 'Save Address',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
              )),
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

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // Get current position
      Position position = await Geolocator.getCurrentPosition();

      // Get location details using placemark
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Extract relevant address components
      String colony = placemarks.first.subLocality ?? ''; // Colony name
      String street = placemarks.first.thoroughfare ?? ''; // Street name
      String sector =
          placemarks.first.subAdministrativeArea ?? ''; // Sector name

      // Construct the full address excluding house number/house name

      setState(() {
        pinCodeController.text = placemarks.first.postalCode ?? '';
        stateController.text = placemarks.first.administrativeArea ?? '';
        cityController.text = placemarks.first.locality ?? '';
        buildingnameController.text = placemarks.first.name ?? '';
        addressController.text = fullAddress;
        fullAddress = '$colony, $street, $sector';
      });
    }
  }
}
