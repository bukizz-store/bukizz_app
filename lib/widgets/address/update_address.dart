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
  bool isLocationLoading = false; // Separate loading state for location
  Position? _cachedPosition; // Cache last known position
  DateTime? _lastLocationFetch; // Track when we last fetched location
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
                      _buildLocationButton(dimensions),
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
                    return; // Prevent further execution
                  }
                  if (buildingnameController.text.isEmpty) {
                    AppConstants.showSnackBarTop(
                        context,
                        'Please Enter House No.',
                        AppColors.error,
                        Icons.error_outline_rounded);
                    return; // Prevent further execution
                  }
                  if (addressController.text.isEmpty) {
                    AppConstants.showSnackBarTop(
                        context,
                        'Please Enter Street Name',
                        AppColors.error,
                        Icons.error_outline_rounded);
                    return; // Prevent further execution
                  }
                  if (nameController.text.isEmpty) {
                    AppConstants.showSnackBarTop(
                        context,
                        'Please Enter Full Name',
                        AppColors.error,
                        Icons.error_outline_rounded);
                    return; // Prevent further execution
                  }
                  if (stateController.text.isEmpty) {
                    AppConstants.showSnackBarTop(context, 'Please Enter State',
                        AppColors.error, Icons.error_outline_rounded);
                    return; // Prevent further execution
                  }
                  if (cityController.text.isEmpty) {
                    AppConstants.showSnackBarTop(context, 'Please Enter City',
                        AppColors.error, Icons.error_outline_rounded);
                    return; // Prevent further execution
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
          child: SafeArea(
            child: Container(
              height: dimensions.height8 * 9,
              width: dimensions.screenWidth,
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensions.width24,
                      vertical: dimensions.height8),
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
          )),
    );
  }

  void onUseMyLocationTap(BuildContext context) async {
    // Prevent multiple simultaneous location requests
    if (isLocationLoading) return;

    setState(() {
      isLocationLoading = true;
    });

    // Show modern loading dialog with progress
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00579E)),
              ),
              SizedBox(height: 16),
              Text(
                'Getting your location...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Text(
                'This will only take a moment',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );

    try {
      Position position;

      // Try to use cached position if it's recent (within 5 minutes)
      if (_cachedPosition != null &&
          _lastLocationFetch != null &&
          DateTime.now().difference(_lastLocationFetch!).inMinutes < 5) {
        position = _cachedPosition!;
        print('Using cached position');
      } else {
        // Check permissions quickly first
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission().timeout(
            Duration(seconds: 5),
            onTimeout: () => LocationPermission.denied,
          );
        }

        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          throw Exception('Location permission denied');
        }

        // Check if location service is enabled
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          throw Exception('Location services are disabled');
        }

        // Try to get last known position first (instant)
        Position? lastKnown = await Geolocator.getLastKnownPosition().timeout(
          Duration(seconds: 2),
          onTimeout: () => null,
        );

        if (lastKnown != null) {
          // Use last known position and update in background
          position = lastKnown;
          _cachedPosition = position;
          _lastLocationFetch = DateTime.now();

          // Optionally get fresh position in background (don't await)
          _updateLocationInBackground();
        } else {
          // Get fresh position with optimized settings
          position = await _getFreshPosition();
        }
      }

      // Start geocoding immediately (don't wait for background updates)
      await _updateAddressFields(position);
    } catch (e) {
      print('Error fetching location: $e');

      // Show specific error messages
      String errorMessage = 'Unable to get location. Please enter manually.';
      Color errorColor = Colors.orange;

      if (e.toString().contains('permission')) {
        errorMessage =
            'Location permission required. Please enable in settings.';
        errorColor = Colors.red;
      } else if (e.toString().contains('disabled') ||
          e.toString().contains('services')) {
        errorMessage = 'Please enable location services and try again.';
        errorColor = Colors.amber;
      } else if (e.toString().contains('timeout')) {
        errorMessage = 'Location request timed out. Please try again.';
        errorColor = Colors.orange;
      }

      if (mounted) {
        AppConstants.showSnackBarTop(
          context,
          errorMessage,
          errorColor,
          Icons.location_off,
        );
      }
    } finally {
      // Always close dialog and reset loading state
      if (mounted) {
        setState(() {
          isLocationLoading = false;
        });
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    }
  }

  // Get fresh position with optimized settings
  Future<Position> _getFreshPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy:
          LocationAccuracy.medium, // Use medium instead of balanced
      timeLimit: Duration(seconds: 4), // Reduced timeout
    ).timeout(
      Duration(seconds: 6),
      onTimeout: () async {
        // Quick fallback with lower accuracy
        return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 3),
        );
      },
    );
  }

  // Update location in background (non-blocking)
  void _updateLocationInBackground() {
    _getFreshPosition().then((position) {
      _cachedPosition = position;
      _lastLocationFetch = DateTime.now();
      // Optionally update address fields with more accurate location
      if (mounted) {
        _updateAddressFields(position);
      }
    }).catchError((e) {
      print('Background location update failed: $e');
    });
  }

  // Extract address updating logic for reuse
  Future<void> _updateAddressFields(Position position) async {
    try {
      // Use parallel approach with optimized geocoding
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      ).timeout(
        Duration(seconds: 4), // Reduced timeout
        onTimeout: () => throw TimeoutException('Geocoding timeout'),
      );

      if (placemarks.isNotEmpty && mounted) {
        final placemark = placemarks.first;

        // Build address components efficiently
        final addressComponents = _buildAddressComponents(placemark);

        setState(() {
          pinCodeController.text = addressComponents['pinCode'] ?? '';
          stateController.text = addressComponents['state'] ?? '';
          cityController.text = addressComponents['city'] ?? '';
          buildingnameController.text = addressComponents['building'] ?? '';
          addressController.text = addressComponents['fullAddress'] ?? '';
        });

        // Show success feedback
        AppConstants.showSnackBarTop(
          context,
          'Location detected successfully!',
          AppColors.success,
          Icons.location_on,
          time: 2,
        );
      }
    } catch (e) {
      print('Geocoding error: $e');
      // Don't show error here as we already have the coordinates
      // User can manually fill the address if geocoding fails
    }
  }

  // Optimize address component building
  Map<String, String> _buildAddressComponents(Placemark placemark) {
    return {
      'pinCode': placemark.postalCode ?? '',
      'state': placemark.administrativeArea ?? '',
      'city': placemark.locality ?? placemark.subAdministrativeArea ?? '',
      'building': placemark.name ?? placemark.street ?? '',
      'fullAddress': [
        placemark.subLocality,
        placemark.thoroughfare,
        placemark.subAdministrativeArea,
      ].where((s) => s != null && s.isNotEmpty).join(', '),
    };
  }

  // Update the location button UI to show loading state
  Widget _buildLocationButton(Dimensions dimensions) {
    return GestureDetector(
      onTap: isLocationLoading ? null : () => onUseMyLocationTap(context),
      child: Container(
        width: dimensions.screenWidth,
        height: dimensions.height8 * 5.5,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1,
                color: isLocationLoading ? Colors.grey : Color(0xFF00579E)),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLocationLoading)
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00579E)),
                ),
              )
            else
              Icon(
                Icons.my_location,
                color: Color(0xFF00579E),
              ),
            SizedBox(width: 8),
            ReusableText(
              text:
                  isLocationLoading ? 'Getting location...' : 'Use my location',
              fontSize: 14,
              color: isLocationLoading ? Colors.grey : Color(0xFF00579E),
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}
