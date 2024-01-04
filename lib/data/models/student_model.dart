import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel{
  String name;
  String email;
  String password;
  String address;
  String uid;
  DateTime dob;
  String mobile;
  String alternateAddress;
  String schoolUID;
  String admnNo;
  String classUID;

  StudentModel({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.uid,
    required this.dob,
    required this.mobile,
    required this.alternateAddress,
    required this.schoolUID,
    required this.admnNo,
    required this.classUID,
  });

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
      'schoolUID': schoolUID,
      'admnNo': admnNo,
      'classUID': classUID,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      name: map['name'] ?? '', // Use an empty string if 'name' is null
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      uid: map['uid'] ?? '',
      dob: map['dob'] ?? '',
      mobile: map['mobile'] ?? '',
      alternateAddress: map['alternateAddress'] ?? '',
      schoolUID: map['schoolUID'] ?? '',
      admnNo: map['admnNo'] ?? '',
      classUID: map['classUID'] ?? '',
    );
  }


// Create a UserDetails instance from QuerySnapshot data
  factory StudentModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return StudentModel(
      name: snapshot.data()['name'] ?? '',
      email: snapshot.data()['email'] ?? '',
      password: snapshot.data()['password'] ?? '',
      address: snapshot.data()['address'] ?? '',
      uid: snapshot.data()['uid'] ?? '',
      dob: snapshot.data()['dob'] ?? '',
      mobile: snapshot.data()['mobile'] ?? '',
      alternateAddress: snapshot.data()['alternateAddress'] ?? '',
      schoolUID: snapshot.data()['schoolUID'] ?? '',
      admnNo: snapshot.data()['admnNo'] ?? '',
      classUID: snapshot.data()['classUID'] ?? '',
    );
  }



}