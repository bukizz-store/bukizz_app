import 'dart:convert';

import 'package:bukizz/data/models/ecommerce/products/variation/set_model.dart';
import 'package:bukizz/data/models/ecommerce/products/variation/stream_model.dart';
import 'package:bukizz/data/models/ecommerce/products/variation/variation.dart';
import 'package:bukizz/data/models/ecommerce/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GeneralProductModel {
  String productId;
  String name;
  String brand;
  String description;
  String categoryId;
  String relatilerId;
  List<VariationGeneral> variation;

  GeneralProductModel({
    required this.productId,
    required this.name,
    required this.description,
    required this.brand,
    required this.categoryId,
    required this.relatilerId,
    required this.variation,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'brand': brand,
      'categoryId': categoryId,
      'variation': variation.map((x) => x.toMap()).toList(),
      'retailerId' : relatilerId,
    };
  }

  factory GeneralProductModel.fromMap(Map<String, dynamic> map) {
    return GeneralProductModel(
        productId: map['productId'] ?? 0,
        name: map['name'] ?? '',
        brand: map['brand'] ?? '',
        description: map['description'] ?? '',
        categoryId: map['categoryId'] ?? 0,
        relatilerId: map['retailerId'] ?? '',
        variation: List<VariationGeneral>.from(map['variation']?.map((x) => VariationGeneral.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());
}