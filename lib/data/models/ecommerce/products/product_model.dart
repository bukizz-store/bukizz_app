import 'dart:async';
import 'dart:convert';

import 'package:bukizz/data/models/ecommerce/products/variation/set_model.dart';
import 'package:bukizz/data/models/ecommerce/products/variation/stream_model.dart';
import 'package:bukizz/data/models/ecommerce/products/variation/variation_model.dart';
import 'package:bukizz/data/models/ecommerce/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

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
  List<dynamic> reviewIdList;
  Map<String , Map<String , Variation>> variation;

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
    required this.reviewIdList,
    required this.variation,
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
      'reviewIdList': reviewIdList,
      'variation': variation,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    var variationMap = map['variation'] ?? {};
    Map<String, Map<String, Variation>> convertedVariationMap = {};

    variationMap.forEach((set, setData) {
      convertedVariationMap[set] = {};
      setData.forEach((stream, streamData) {
        convertedVariationMap[set]![stream] = Variation.fromMap(streamData);
      });
    });

    return ProductModel(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      categoryId: map['categoryId'] ?? '',
      classId: map['classId'] ?? '',
      board: map['board'] ?? '',
      stream: List<StreamData>.from(map['stream']?.map((x) => StreamData.fromMap(x)) ?? []),
      set: List<SetData>.from(map['set']?.map((x) => SetData.fromMap(x)) ?? []),
      retailerId: map['retailerId'] ?? '',
      reviewIdList: List<dynamic>.from(map['reviewIdList'] ?? []),
      variation: convertedVariationMap,
    );
  }

  factory ProductModel.fromGeneralMap(Map<String, dynamic> map) {
    var variationMap = map['variation'] ?? {};
    Map<String, Map<String, Variation>> convertedVariationMap = {};
    int p = 0;

    variationMap.forEach((set) {
      convertedVariationMap[(p).toString()] = {};
      convertedVariationMap[p.toString()]![0.toString()] = Variation.fromMap(set);
      p++;
    });

    return ProductModel(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      categoryId: map['categoryId'] ?? '',
      classId: '',
      board:  map['brand'] ?? '',
      set: List<SetData>.from(map['variation']?.map((x) => SetData.fromMap(x)) ?? []),
      stream: [],
      retailerId: map['retailerId'] ?? '',
      reviewIdList: List<dynamic>.from(map['reviewIdList'] ?? []),
      variation: convertedVariationMap,
    );
  }

  //fromJson
  factory ProductModel.fromJson(dynamic json) {
    return ProductModel(
      productId: json['productId'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      classId: json['classId'] ?? '',
      board: json['board'] ?? '',
      stream: List<StreamData>.from(json['stream']?.map((x) => StreamData.fromMap(x))),
      set: List<SetData>.from(json['set']?.map((x) => SetData.fromMap(x))),
      retailerId: json['retailerId'] ?? '',
      reviewIdList: List<dynamic>.from(json['reviewIdList'] ?? []),
      variation:  Map<String , Map<String , Variation>>.from(json['variation'] ?? {}),
    );
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    var variationMap = Map<String, Map<String, Variation>>.from(data['variation']);
    return ProductModel(
      productId: data['productId'],
      name: data['name'],
      description: data['description'],
      categoryId: data['categoryId'],
      classId: data['classId'],
      board: data['board'],
      retailerId: data['retailerId'],
      stream: List<StreamData>.from(data['stream'].map((x) => StreamData.fromJson(x))),
      set: List<SetData>.from(data['set'].map((x) => SetData.fromJson(x))),
      reviewIdList: List<dynamic>.from(data['reviewIdList']),
      variation: variationMap,
    );
  }


  // static Future<void> updateProductData() async {
  //   //function to update the current product data by finding the product where productId is equals to "BSCL6" and i want to add a new field for list of stream and set
  //   await FirebaseFirestore.instance
  //       .collection('products')
  //       .where('categoryId', isEqualTo: 'ST')
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       FirebaseFirestore.instance
  //           .collection('products')
  //           .doc(element.id)
  //           .update({
  //         'stream': [],
  //         'set': [],
  //       }).then((value) => print('Product updated successfully'));
  //     });
  //   });
  //
  // }
  static ProductModel randomProductData() {

    var streamData = StreamData(
      name: 'PCM',
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL12.png?alt=media&token=b82e9a43-dbe9-4a57-8b14-14c1e1d0c8a7'],
      sku: 10,
      price: 2100,
      salePrice: 1700,
    );
    var streamData2 = StreamData(
      name: 'PCB',
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL12.png?alt=media&token=b82e9a43-dbe9-4a57-8b14-14c1e1d0c8a7'],
      sku: 10,
      price: 1800,
      salePrice: 1600,
    );var streamData3 = StreamData(
      name: 'Commerce',
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL12.png?alt=media&token=b82e9a43-dbe9-4a57-8b14-14c1e1d0c8a7'],
      sku: 10,
      price: 1400,
      salePrice: 1200,
    );
    var streamData4= StreamData(
      name: 'Arts',
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL12.png?alt=media&token=b82e9a43-dbe9-4a57-8b14-14c1e1d0c8a7'],
      sku: 10,
      price: 30000,
      salePrice: 1400,
    );

    var setData = SetData(
      name: 'BookSet',
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL11.png?alt=media&token=a785215f-81c4-4530-bd81-ebcdd7c8fdb4'],
      sku: 10,
      price: 2102,
      salePrice: 990,
    );
    var setData2 = SetData(
      name: 'BookSet + NotebookSet',
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL11.png?alt=media&token=a785215f-81c4-4530-bd81-ebcdd7c8fdb4'],
      sku: 10,
      price: 3160,
      salePrice: 2890,
    );

    var variation =  Variation(
      price: 2100,
      salePrice: 1700,
      sku: 10,
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL6.png?alt=media&token=0f03cf71-8814-4812-bb85-3381286379d2'],
      costPerItem: 200,
      reviewIdList: [],
    );

    var variation2 =  Variation(
      price: 2200,
      salePrice: 1900,
      sku: 10,
      image: ['https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL6.png?alt=media&token=0f03cf71-8814-4812-bb85-3381286379d2'],
      costPerItem: 200,
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
      set: [setData2, setData],
      reviewIdList: [],
      variation: {
        // '0': {'0': variation.toMap(), '1': variation2.toMap()},
        // '1': {'0': variation2.toMap(), '1': variation.toMap()},
      },
    );
  }

  //update a particular product data by finding the product where productId is equals to "BSCL6" and i want to add a new field of variation in it
  // static void updateProductData() {
  //   var variation =  Variation(
  //     price: 1580,
  //     salePrice: 1240,
  //     sku: 25,
  //     image: 'https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL6.png?alt=media&token=0f03cf71-8814-4812-bb85-3381286379d2',
  //     costPerItem: 263,
  //     reviewIdList:  [],
  //   );
  //
  //   var variation2 =  Variation(
  //     price: 6099,
  //     salePrice: 5110,
  //     sku: 10,
  //     image: 'https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL6.png?alt=media&token=0f03cf71-8814-4812-bb85-3381286379d2',
  //     costPerItem: 200,
  //     reviewIdList: [],
  //   );
  //
  //   Map<String , dynamic> variationMap = {
  //     '0': {'0': variation.toMap(), '1': variation2.toMap(),'2':variation.toMap(),'3':variation.toMap()},
  //     '1': {'0': variation2.toMap(), '1': variation.toMap(),'2':variation.toMap(),'3':variation2.toMap()},
  //   };
  //
  //   // List<Variation> variationList = [variation.toMap(), variation2];
  //
  //   FirebaseFirestore.instance
  //       .collection('products')
  //       .where('productId', isEqualTo: 'BSCL12')
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       FirebaseFirestore.instance
  //           .collection('products')
  //           .doc(element.id)
  //           .update({
  //         'variation': variationMap,
  //       }).then((value) => print('Product updated successfully'));
  //     });
  //   });
  // }

  //add product to firebase database with the random product data
  static void addProductData() {
    ProductModel product = randomProductData();
    FirebaseFirestore.instance.collection('products').add(product.toMap()).then((value) => print('Product added successfully'));
  }



  String toJson() => json.encode(toMap());
}