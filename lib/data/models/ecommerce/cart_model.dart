
import 'dart:convert';

import '../../../constants/constants.dart';

class CartModel{
  double totalAmount;
  Map<String , int> productsId;
  String address;


  CartModel({
    required this.totalAmount,
    required this.productsId,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalAmount': totalAmount,
      'products': productsId,
      'address': address ?? AppConstants.userData.address,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      totalAmount: map['totalAmount'] ?? 0.0,
      productsId: map['products'] ?? {},
      address: map['address'] ?? '',
    );
  }

  //Create function to load string data from shared prefereances and then convert it to map and then use it in checkout screen.
  factory CartModel.fromJson(Map<String, dynamic> map) => CartModel.fromMap(map);

  String toJson() => json.encode(toMap());
}