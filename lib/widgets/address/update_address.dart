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
              height: 70.h,
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
                        controller: nameController,
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      CustomTextForm(
                        width: dimensions.width342,
                        height: dimensions.height8 * 5.5,
                        hintText: 'Phone number (Required) *',
                        controller: phoneController,
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      CustomTextForm(
                        width: dimensions.width342,
                        height: dimensions.height8 * 5.5,
                        hintText: 'Email',
                        controller: emailController,
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
                            hintText: 'Pin Code (Required) *',
                            controller: pinCodeController,
                          ),
                          GestureDetector(
                            onTap: onUseMyLocationTap,
                            child: Container(
                              width: dimensions.width16 * 9.2,
                              height: dimensions.height8 * 4.5,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.50, color: Color(0xFF00579E)),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                          )
                        ],
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
                          controller: alternatePhoneController,
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
                            controller: stateController,
                          ),
                          CustomTextForm(
                            width: dimensions.width16 * 9.2,
                            height: dimensions.height8 * 5.5,
                            hintText: 'City (Required) *',
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
                        controller: buildingnameController,
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      CustomTextForm(
                        width: dimensions.width342,
                        height: dimensions.height8 * 5.5,
                        hintText: 'Road name, Area, Colony (Required) *',
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
          Address address = Address(
              name: nameController.text,
              houseNo: buildingnameController.text,
              street: fullAddress,
              city: cityController.text,
              state: stateController.text,
              pinCode: pinCodeController.text,
              phone: phoneController.text,
              email: emailController.text);
          widget.keyAddress
              ? context.read<UpdateUserData>().updateUserAddress(address)
              : context
                  .read<UpdateUserData>()
                  .updateUserAlternateAddress(address);
          if(widget.keyAddress){
            context.read<UpdateAddressRepository>().address = address;
          }
          else{
            context.read<UpdateAddressRepository>().alternateAddress = address;
          }
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