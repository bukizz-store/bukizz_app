import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamData {
  String? name;
  String? price;

  StreamData({this.name, this.price});

  StreamData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;
  }

  //tomap
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }

  //frommap
  factory StreamData.fromMap(Map<String, dynamic> map) {
    return StreamData(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
    );
  }

}