import 'dart:convert';

import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/constants/shared_pref_helper.dart';
import 'package:bukizz/data/models/ecommerce/address/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserData extends ChangeNotifier{
  Future updateUserAddress(Address address)async {
  //Make a function to update the address of the user in firebase and also in the shared preferences
    await FirebaseFirestore.instance.collection('userDetails').doc(AppConstants.userData.uid).update({
      'address': address.toMap(),
    }).then((value) => print("User Address Updated"))
        .catchError((error) => print("Failed to update user address: $error"));

    AppConstants.userData.address = address;
    String addresss = address.city;
    saveLocationSetToSharedPreferences(addresss);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', jsonEncode(AppConstants.userData.toJson()));
    notifyListeners();
  }

  Future updateUserAlternateAddress(Address address)async {
    //Make a function to update the address of the user in firebase and also in the shared preferences
    await FirebaseFirestore.instance.collection('userDetails').doc(AppConstants.userData.uid).update({
      'alternateAddress': address.toMap(),
    }).then((value) => print("User Alternate Address Updated"))
        .catchError((error) => print("Failed to update user address: $error"));

    AppConstants.userData.alternateAddress = address;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', jsonEncode(AppConstants.userData.toJson()));
    notifyListeners();
  }

  Future saveLocationSetToSharedPreferences(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefHelper.location, location);
    AppConstants.location = prefs.getString(SharedPrefHelper.location)! ?? '';
    notifyListeners();
  }
}