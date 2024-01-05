import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import '../../constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainUserDetails {
  String name;
  String email;
  String password;
  String address;
  String uid;
  DateTime dob;
  String mobile;
  String alternateAddress;
  List<String> studentsUID;
  List<String> orderID;

  MainUserDetails({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.uid,
    required this.dob,
    required this.mobile,
    required this.alternateAddress,
    this.studentsUID = const [],
    this.orderID = const [],
  });

  // Create a map representation of the user details
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'uid': uid,
      'dob': dob,
      'mobile': mobile,
      'alternateAddress': alternateAddress,
      'studentsUID': studentsUID,
      'orderID': orderID,
    };
  }

  // Hash the password using SHA-256
  static String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Factory constructor to create a UserDetails object from a map
  factory MainUserDetails.fromMap(Map<String, dynamic> map) {
    return MainUserDetails(
      name: map['name'] ?? '', // Use an empty string if 'name' is null
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      uid: map['uid'] ?? '',
      dob: map['dob'] ?? '',
      mobile: map['mobile'] ?? '',
      alternateAddress: map['alternateAddress'] ?? '',
      studentsUID: map['studentsUID'] ?? [],
      orderID: map['orderID'] ?? [],
    );
  }

  // Method to push user data to Firebase with an empty string for name, class, and section
  Future<void> pushToFirebase() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('userDetails')
              .where('email', isEqualTo: email)
              .get();

      if (querySnapshot.docs.isEmpty) {
        // If no document with the same email exists, add a new document
        await FirebaseFirestore.instance.collection('userDetails').add(toMap());
      } else {
        // If a document with the same email exists, you may choose to handle this case accordingly
        print('User with email $email already exists in Firestore');
      }

      AppConstants.userData = MainUserDetails.fromMap(toMap());
      print(AppConstants.userData);
    } catch (e) {
      print('Error pushing user data to Firebase: $e');
    }
  }

  // Save user details to shared preferences
  Future<void> saveToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  // Load user details from shared preferences
  static Future<MainUserDetails?> loadFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email') ?? '';
    String? password = prefs.getString('password') ?? '';
    String? uid = prefs.getString('uid') ?? '';
    bool? isLogin = prefs.getBool('isLogin');

    AppConstants.isLogin = isLogin ?? false;
    return MainUserDetails(
      name: '',
      email: email,
      password: password,
      address: '',
      uid: uid,
      dob: DateTime.now(),
      mobile: '',
      alternateAddress: '',
      orderID: [],
      studentsUID: [],
    );
  }

  // Create a UserDetails instance from QuerySnapshot data
  factory MainUserDetails.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return MainUserDetails(
      name: snapshot['name'] ?? '',
      email: snapshot['email'] ?? '',
      password: snapshot['password'] ?? '',
      address: snapshot['address'] ?? '',
      uid: snapshot['uid'] ?? '',
      dob: snapshot['dob'] ?? '',
      mobile: snapshot['mobile'] ?? '',
      alternateAddress: snapshot['alternateAddress'] ?? '',
      studentsUID: snapshot['studentsUID'] ?? [],
      orderID: snapshot['orderID'] ?? [],
    );
  }
}
