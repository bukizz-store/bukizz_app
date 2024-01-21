import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainUserDetails {
  String name;
  String email;
  String password;
  String address;
  String uid;
  String dob;
  String mobile;
  String alternateAddress;
  List<dynamic> studentsUID;
  List<dynamic> orderID;

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
      dob: map['dob'] ?? DateTime.now().toIso8601String(),
      mobile: map['mobile'] ?? '',
      alternateAddress: map['alternateAddress'] ?? '',
      studentsUID: map['studentsUID'] ?? [],
      orderID: map['orderID'] ?? [],
    );
  }


  // Convert class object to JSON
  Map<String, dynamic> toJson() {
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

  // Create class object from JSON
  factory MainUserDetails.fromJson(Map<String, dynamic> json) {
    return MainUserDetails(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      uid: json['uid'],
      dob: json['dob'],
      mobile: json['mobile'],
      alternateAddress: json['alternateAddress'],
      studentsUID: List<dynamic>.from(json['studentsUID']),
      orderID: List<dynamic>.from(json['orderID']),
    );
  }
  // Method to push user data to Firebase with an empty string for name, class, and section
  Future<void> pushToFirebase(UserCredential authResult) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('userDetails')
              .where('email', isEqualTo: email)
              .get();

      if (querySnapshot.docs.isEmpty) {
        // If no document with the same email exists, add a new document
        await FirebaseFirestore.instance.collection('userDetails').doc(authResult.user!.uid).set(toMap());
        AppConstants.userData =  MainUserDetails.fromMap(toMap());
      } else {
        // If a document with the same email exists, you may choose to handle this case accordingly
        print('User with email $email already exists in Firestore');
      }

    // AppConstants.userData = MainUserDetails.fromMap(toMap());
    print(toMap());

    } catch (e) {
      print('Error pushing user data to Firebase: $e');
    }

  }

  // Save user details to shared preferences
  Future<void> saveToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', jsonEncode(AppConstants.userData.toJson()));

    prefs.setString('uid', uid);
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  // Load user details from shared preferences
  static Future<MainUserDetails?> loadFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email') ?? '';
    String? password = prefs.getString('password') ?? '';
    String? userData = prefs.getString('userData') ?? '';
    String? uid = prefs.getString('uid') ?? '';
    bool? isLogin = prefs.getBool('isLogin');

    print(userData);

    if (userData != '') {
      Map<String, dynamic> map = jsonDecode(userData);
      print(map);
      AppConstants.isLogin = isLogin ?? false;
      AppConstants.userData = MainUserDetails.fromMap(map);
      return MainUserDetails.fromMap(map);
    }

    return MainUserDetails(name: '', email: '', password: '', address: '', uid: '', dob: '', mobile: '', alternateAddress: '');
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
      dob: snapshot['dob'] ?? DateTime.now().toIso8601String(),
      mobile: snapshot['mobile'] ?? '',
      alternateAddress: snapshot['alternateAddress'] ?? '',
      studentsUID: snapshot['studentsUID'] ?? [],
      orderID: snapshot['orderID'] ?? [],
    );
  }
}
