import 'dart:convert';

import 'package:bukizz_1/data/models/ecommerce/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String productId;
  String name;
  String description;
  double price;
  int stockQuantity;
  String categoryId;
  String image;
  String classId;
  String board;
  String salePrice;
  List<dynamic> reviewIdList;

  ProductModel({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.categoryId,
    required this.image,
    required this.classId,
    required this.board,
    required this.salePrice,
    required this.reviewIdList
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'price': price,
      'stockQuantity': stockQuantity,
      'categoryId': categoryId,
      'image': image,
      'classId': classId,
      'board': board,
      'salePrice': salePrice,
      'reviewIdList': reviewIdList
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0.0,
      stockQuantity: map['stockQuantity'] ?? 0,
      categoryId: map['categoryId'] ?? 0,
      image: map['image'] ?? '',
      classId: map['classId'] ?? '',
      board: map['board'] ?? '',
      salePrice: map['salePrice'] ?? '',
      reviewIdList: map['reviewIdList'] ?? []
    );
  }

  //function to send random product data to firebase
  static ProductModel randomProductData() {
    return ProductModel(
      productId: 'bookset_1_2',
      name: 'Class 2nd',
      description: 'This is a sample product for testing purposes.',
      price: 600,
      stockQuantity: 10,
      categoryId: 'bookset',
      image: 'https://www.tiwariacademy.com/app/uploads/2021/05/NCERT-Books-Class-2.png',
      classId: '2',
      board: 'CBSE',
      salePrice: '580',
      reviewIdList: [],
    );
  }

  //Create a function to send this random product data to firebase in new collection named "products"
static Future<void> sendRandomProductData() async {
    ProductModel product = ProductModel.randomProductData();
    await FirebaseFirestore.instance
        .collection('products')
        .add(product.toMap()).then((value) => {
          print('Product added successfully')
        }).catchError((error) => {
          print('Failed to add product: $error')
        });
  }



  String toJson() => json.encode(toMap());
}