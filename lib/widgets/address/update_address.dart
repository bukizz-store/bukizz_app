import 'dart:async';

import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/repository/address/update_address.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../data/models/ecommerce/address/address_model.dart';
import '../../data/providers/auth/updateUserData.dart';
import '../../utils/dimensions.dart';
import '../circle/custom circleAvatar.dart';
import '../text and textforms/Reusable_text.dart';
import '../text and textforms/textformAddress.dart';

class UpdateAddress extends StatefulWidget {
  final Address address;
  final bool keyAddress;
  UpdateAddress({super.key, required this.address, required this.keyAddress});

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  bool showAlternatePhoneField = false;
  bool isLoading = false; // Add loading state
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
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.address.name;
    phoneController.text = widget.address.phone;
    emailController.text = widget.address.email;
    pinCodeController.text = widget.address.pinCode;
    stateController.text = widget.address.state;
    cityController.text = widget.address.city;
    buildingnameController.text = widget.address.houseNo;
    addressController.text = widget.address.street;
  }

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Address'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 12.sp,
            ),
            Container(
              width: dimensions.screenWidth,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: dimensions.width24,
                    vertical: dimensions.height8 * 3),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                      GestureDetector(
                        onTap: () => onUseMyLocationTap(context),
                        child: Container(
                          width: dimensions.screenWidth,
                          height: dimensions.height8 * 5.5,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFF00579E)),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.my_location,
                                color: Color(0xFF00579E),
                              ),
                              ReusableText(
                                text: 'Use my location',
                                fontSize: 14,
                                color: Color(0xFF00579E),
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: dimensions.height16,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       showAlternatePhoneField = !showAlternatePhoneField;
                      //     });
                      //   },
                      //   child: Container(
                      //     child: Row(
                      //       children: [
                      //         Icon(
                      //             showAlternatePhoneField
                      //                 ? Icons.remove
                      //                 : Icons.add,
                      //             color: Color(0xFF00579E)),
                      //         ReusableText(
                      //           text: showAlternatePhoneField
                      //               ? 'Dont Add Alternate Phone'
                      //               : 'Add Alternate Phone',
                      //           fontSize: 14,
                      //           color: Color(0xFF00579E),
                      //           fontWeight: FontWeight.w500,
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // if (showAlternatePhoneField)
                      //   SizedBox(
                      //     height: dimensions.height8 * 2,
                      //   ),
                      // if (showAlternatePhoneField)
                      //   CustomTextForm(
                      //     width: dimensions.width342,
                      //     height: dimensions.height8 * 5.5,
                      //     hintText: 'Alternate Phone',
                      //     controller: alternatePhoneController,
                      //     isPhoneNo: true,
                      //   ),
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
                            labelText: 'State',
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
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      CustomTextForm(
                        width: dimensions.screenWidth,
                        height: dimensions.height8 * 5.5,
                        hintText: 'Pin Code (Required) *',
                        labelText: 'Pin Code',
                        controller: pinCodeController,
                        isPinCode: true,
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
        onTap: isLoading
            ? null
            : () async {
                // Disable tap when loading
                // ...existing validation code...
                if (phoneController.text.length != 10) {
                  AppConstants.showSnackBarTop(
                      context,
                      'Please Enter Valid Number',
                      AppColors.error,
                      Icons.error_outline_rounded);
                  return; // Prevent further execution
                }
                if (pinCodeController.text.length != 6) {
                  print('Updating primary address');
                  AppConstants.showSnackBarTop(
                      context,
                      'Please Enter Valid Pincode',
                      AppColors.error,
                      Icons.error_outline_rounded);
                }
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(emailController.text.toString())) {
                  AppConstants.showSnackBarTop(
                      context,
                      'Please Enter a valid Email',
                      AppColors.error,
                      Icons.error_outline_rounded);
                      
                }
                if (buildingnameController.text.isEmpty) {
                  AppConstants.showSnackBarTop(
                      context,
                      'Please Enter House No.',
                      AppColors.error,
                      Icons.error_outline_rounded);
                }
                if (addressController.text.isEmpty) {
                  AppConstants.showSnackBarTop(
                      context,
                      'Please Enter Street Name',
                      AppColors.error,
                      Icons.error_outline_rounded);
                }
                if (nameController.text.isEmpty) {
                  AppConstants.showSnackBarTop(
                      context,
                      'Please Enter Full Name',
                      AppColors.error,
                      Icons.error_outline_rounded);
                }
                if (stateController.text.isEmpty) {
                  AppConstants.showSnackBarTop(context, 'Please Enter State',
                      AppColors.error, Icons.error_outline_rounded);
                }
                if (cityController.text.isEmpty) {
                  AppConstants.showSnackBarTop(context, 'Please Enter City',
                      AppColors.error, Icons.error_outline_rounded);
                }

                setState(() {
                  isLoading = true;
                });

                try {
                  //Save Address logic here
                  Address address = Address(
                    name: nameController.text,
                    houseNo: buildingnameController.text,
                    street: addressController.text,
                    city: cityController.text,
                    state: stateController.text,
                    pinCode: pinCodeController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                  );

                  if (widget.keyAddress) {
                    await context
                        .read<UpdateUserData>()
                        .updateUserAddress(address);
                    context.read<UpdateAddressRepository>().address = address;
                  } else {
                    await context
                        .read<UpdateUserData>()
                        .updateUserAlternateAddress(address);
                    context.read<UpdateAddressRepository>().alternateAddress =
                        address;
                  }

                  AppConstants.showSnackBarTop(
                      context,
                      'Address updated successfully',
                      AppColors.success,
                      Icons.check_circle);
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Error updating address: $e');

                  // Show user-friendly error message based on error type
                  if (e.toString().contains('UNAVAILABLE') ||
                      e.toString().contains('UnknownHostException') ||
                      e.toString().contains('firestore.googleapis.com') ||
                      e.toString().contains('Unable to resolve host')) {
                    AppConstants.showSnackBarTop(
                        context,
                        'Network error. Please check your internet connection and try again.',
                        AppColors.error,
                        Icons.wifi_off);
                  } else {
                    AppConstants.showSnackBarTop(
                        context,
                        'Failed to update address. Please try again.',
                        AppColors.error,
                        Icons.error_outline_rounded);
                  }
                } finally {
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                }
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
                  color: isLoading ? Colors.grey : Color(0xFF058FFF),
                ),
                child: Center(
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : ReusableText(
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

  void onUseMyLocationTap(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Fetching location...'),
            ],
          ),
        );
      },
    );

    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are not enabled');
        Navigator.pop(context);
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          print('Location permission denied');
          Navigator.pop(context);
          return;
        }
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        // Get current position with optimized settings and timeout
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy
              .medium, // Changed from default to medium for faster response
          timeLimit: Duration(
              seconds: 8), // Added timeout to prevent indefinite waiting
        ).timeout(
          Duration(seconds: 12), // Additional timeout wrapper
          onTimeout: () async {
            // Fallback to lower accuracy if timeout
            return await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.low,
              timeLimit: Duration(seconds: 5),
            );
          },
        );

        // Get location details using placemark with timeout
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        ).timeout(
          Duration(seconds: 8),
          onTimeout: () => throw TimeoutException('Geocoding timeout'),
        );

        String colony = placemarks.first.subLocality ?? '';
        String street = placemarks.first.thoroughfare ?? '';
        String sector = placemarks.first.subAdministrativeArea ?? '';
        String fullAddress = '$colony, $street, $sector';

        setState(() {
          pinCodeController.text = placemarks.first.postalCode ?? '';
          stateController.text = placemarks.first.administrativeArea ?? '';
          cityController.text = placemarks.first.locality ?? '';
          buildingnameController.text = placemarks.first.name ?? '';
          addressController.text = fullAddress;
        });
      }
    } catch (e) {
      print('Error fetching location: $e');

      // Show error message to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unable to get location. Please enter manually.'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } finally {
      // Always close the dialog
      if (mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }
}
