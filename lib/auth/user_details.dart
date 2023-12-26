import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails {
  String name;
  String className;
  String section;
  String email;
  String password;
  String uniqueId;
  String uniqueIDPassword;
  String schoolCode;
  String address;

  UserDetails({
    required this.name,
    required this.className,
    required this.section,
    required this.email,
    required this.password,
    required this.uniqueId,
    required this.uniqueIDPassword,
    required this.schoolCode,
    required this.address,
  });

  // Create a map representation of the user details
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'class': className,
      'section': section,
      'email': email,
      'password': password,
      'uniqueId': uniqueId,
      'uniqueIDPassword': uniqueIDPassword,
      'schoolCode': schoolCode,
      'address': address,
    };
  }

  // Factory constructor to create a UserDetails object from a map
  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      name: map['name'] ?? '', // Use an empty string if 'name' is null
      className: map['class'] ?? '',
      section: map['section'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      uniqueId: map['uniqueId'] ?? '',
      uniqueIDPassword: map['uniqueIDPassword'] ?? '',
      schoolCode: map['schoolCode'] ?? '',
      address: map['address'] ?? '',
    );
  }

  // Method to push user data to Firebase with an empty string for name, class, and section
  Future<void> pushToFirebase() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
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

      AppConstants.userData = UserDetails.fromMap(toMap());
      print(AppConstants.userData);
    } catch (e) {
      print('Error pushing user data to Firebase: $e');
    }
  }

  // Save user details to shared preferences
  Future<void> saveToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  // Load user details from shared preferences
  static Future<UserDetails?> loadFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    bool? isLogin = prefs.getBool('isLogin');

    AppConstants.isLogin = isLogin!;

    if (email != null && password != null) {
      return UserDetails(name: '', className: '', section: '', email: email, password: password , uniqueId: '',
        uniqueIDPassword: '',
        schoolCode: '',
        address: '', );
    } else {
      return null;
    }
  }

  // Create a UserDetails instance from QuerySnapshot data
  factory UserDetails.fromQuerySnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserDetails(
      name: snapshot['name'] ?? '',
      className: snapshot['class'] ?? '',
      section: snapshot['section'] ?? '',
      email: snapshot['email'] ?? '',
      password: snapshot['password'] ?? '',
      uniqueId: snapshot['uniqueId'] ?? '',
      uniqueIDPassword: snapshot['uniqueIDPassword'] ?? '',
      schoolCode: snapshot['schoolCode'] ?? '',
      address: snapshot['address'] ?? '',
    );
  }
}
