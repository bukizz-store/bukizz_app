import 'dart:convert';

import 'package:bukizz/data/models/ecommerce/products/variation/set_model.dart';
import 'package:bukizz/data/models/ecommerce/products/variation/stream_model.dart';
import 'package:bukizz/data/models/ecommerce/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String productId;
  String name;
  String description;
  String categoryId;
  String classId;
  String board;
  String retailerId;
  List<StreamData> stream;
  List<SetData> set;

  ProductModel({
    required this.productId,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.classId,
    required this.board,
    required this.stream,
    required this.set,
    required this.retailerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'categoryId': categoryId,
      'classId': classId,
      'board': board,
      'stream': stream.map((x) => x.toMap()).toList(),
      'set': set.map((x) => x.toMap()).toList(),
      'retailerId': retailerId,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      categoryId: map['categoryId'] ?? 0,
      classId: map['classId'] ?? '',
      board: map['board'] ?? '',
      stream: List<StreamData>.from(map['stream']?.map((x) => StreamData.fromMap(x))),
      set: List<SetData>.from(map['set']?.map((x) => SetData.fromMap(x))),
      retailerId: map['retailerId'] ?? '',
    );
  }


  static Future<void> updateProductData() async {
    //function to update the current product data by finding the product where productId is equals to "BSCL6" and i want to add a new field for list of stream and set
    await FirebaseFirestore.instance
        .collection('products')
        .where('categoryId', isEqualTo: 'ST')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection('products')
            .doc(element.id)
            .update({
          'stream': [],
          'set': [],
        }).then((value) => print('Product updated successfully'));
      });
    });

  }
  static ProductModel randomProductData() {

    var streamData = StreamData(
      name: 'PCM',
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL12.png?alt=media&token=b82e9a43-dbe9-4a57-8b14-14c1e1d0c8a7'],
      sku: 10,
      price: 2100,
      salePrice: 1700,
      reviewIdList: [],
    );
    var streamData2 = StreamData(
      name: 'PCB',
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL12.png?alt=media&token=b82e9a43-dbe9-4a57-8b14-14c1e1d0c8a7'],
      sku: 10,
      price: 1800,
      salePrice: 1600,
      reviewIdList: [],
    );var streamData3 = StreamData(
      name: 'Commerce',
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL12.png?alt=media&token=b82e9a43-dbe9-4a57-8b14-14c1e1d0c8a7'],
      sku: 10,
      price: 1400,
      salePrice: 1200,
      reviewIdList: [],
    );
    var streamData4= StreamData(
      name: 'Arts',
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL12.png?alt=media&token=b82e9a43-dbe9-4a57-8b14-14c1e1d0c8a7'],
      sku: 10,
      price: 30000,
      salePrice: 1400,
      reviewIdList: [],
    );

    var setData = SetData(
      name: 'BookSet',
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL11.png?alt=media&token=a785215f-81c4-4530-bd81-ebcdd7c8fdb4'],
      sku: 10,
      price: 2102,
      salePrice: 990,
      reviewIdList: [],
    );
    var setData2 = SetData(
      name: 'BookSet + NotebookSet',
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL11.png?alt=media&token=a785215f-81c4-4530-bd81-ebcdd7c8fdb4'],
      sku: 10,
      price: 3160,
      salePrice: 2890,
      reviewIdList: [],
    );

    return ProductModel(
      productId: 'BSCL12',
      name: 'Class 12th',
      description: 'All the books for Class 12 as per the curriculum. 16 notebook set as prescribed and mandatory add ons.',
      categoryId: 'BookSet',
      classId: 'CLA12',
      board: 'CBSE',
      retailerId: '',
      stream: [streamData,streamData2,streamData3,streamData4],
      set: [setData2, setData]
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