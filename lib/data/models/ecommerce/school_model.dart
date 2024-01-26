import 'dart:convert';

import 'package:bukizz_1/data/models/ecommerce/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolModel{
  String schoolId;
  String name;
  String address;
  String city;
  String state;
  String board;
  String pincode;
  String contactNumber;
  String email;
  String website;
  String logo;
  String banner;
  String aboutUs;
  String mission;
  String image;
  String ourInspiration;
  List<dynamic> productsId;

  SchoolModel({
    required this.schoolId,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.board,
    required this.pincode,
    required this.contactNumber,
    required this.email,
    required this.website,
    required this.logo,
    required this.banner,
    required this.aboutUs,
    required this.productsId,
    this.mission = '',
    this.image = '',
    this.ourInspiration = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'schoolId': schoolId,
      'name': name,
      'address': address,
      'city': city,
      'state': state,
      'board': board,
      'pincode': pincode,
      'contactNumber': contactNumber,
      'email': email,
      'website': website,
      'logo': logo,
      'banner': banner,
      'aboutUs': aboutUs,
      'productsId': productsId,
      'mission': mission,
      'image': image,
      'ourInspiration': ourInspiration,
    };
  }

  factory SchoolModel.fromMap(Map<String, dynamic> map) {
    return SchoolModel(
      schoolId: map['schoolId'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      board: map['board'] ?? '',
      pincode: map['pincode'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      email: map['email'] ?? '',
      website: map['website'] ?? '',
      logo: map['logo'] ?? '',
      banner: map['banner'] ?? '',
      aboutUs: map['aboutUs'] ?? '',
      productsId: map['productsId'] ?? [],
      mission: map['mission'] ?? '',
      image: map['image'] ?? '',
      ourInspiration: map['ourInspiration'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}