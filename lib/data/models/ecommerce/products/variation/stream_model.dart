import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamData {
  String name;
  List<String> image;
  int sku;
  int price;
  int salePrice;
  List<dynamic> reviewIdList;

  StreamData({
    required this.name,
    required this.price,
    required this.image,
    required this.salePrice,
    required this.sku,
    required this.reviewIdList,
  });

  StreamData.fromJson(Map<String, dynamic> json) :
        name = json['name'],
        image = json['image'],
        salePrice = json['salePrice'],
        sku = json['sku'],
        reviewIdList = json['reviewIdList'],
        price = json['price'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['sku'] = sku;
    data['salePrice'] = salePrice;
    data['reviewIdList'] = reviewIdList;
    data['price'] = price;
    return data;
  }

  //tomap
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'sku': sku,
      'salePrice': salePrice,
      'reviewIdList': reviewIdList,
      'price': price,
    };
  }

  //frommap
  factory StreamData.fromMap(Map<String, dynamic> map) {
    return StreamData(
      name: map['name'] ?? '',
      image: List<String>.from(map['image'] ?? []),
      sku: map['sku'] ?? 0,
      salePrice: map['salePrice'] ?? 0,
      reviewIdList: map['reviewIdList'] ?? [],
      price: map['price'] ?? 0,
    );
  }

}