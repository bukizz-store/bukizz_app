import 'dart:convert';

import 'package:bukizz/data/models/ecommerce/products/set_model.dart';
import 'package:bukizz/data/models/ecommerce/products/stream_model.dart';
class StationaryModel {
  String productId;
  String name;
  String description;
  double price;
  int stockQuantity;
  String categoryId;
  String image;
  String classId;
  String board;
  int salePrice;
  List<StreamData> stream;
  List<SetData> set;
  List<dynamic> reviewIdList;

  StationaryModel({
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
    required this.stream,
    required this.set,
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
      'stream': stream.map((x) => x.toMap()).toList(),
      'set': set.map((x) => x.toMap()).toList(),
      'reviewIdList': reviewIdList
    };
  }

  factory StationaryModel.fromMap(Map<String, dynamic> map) {
    return StationaryModel(
        productId: map['productId'] ?? 0,
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        price: (map['price'] ?? 0).toDouble(),
        stockQuantity: map['stockQuantity'] ?? 0,
        categoryId: map['categoryId'] ?? 0,
        image: map['image'] ?? '',
        classId: map['classId'] ?? '',
        board: map['board'] ?? '',
        salePrice: map['salePrice'] ?? 0,
        stream: List<StreamData>.from(map['stream']?.map((x) => StreamData.fromMap(x))),
        set: List<SetData>.from(map['set']?.map((x) => SetData.fromMap(x))),
        reviewIdList: map['reviewIdList'] ?? []
    );
  }


  // static Future<void> updateProductData() async {
  //   //function to update the current product data by finding the product where productId is equals to "BSCL6" and i want to add a new field for list of stream and set
  //   await FirebaseFirestore.instance
  //       .collection('products')
  //       .where('productId', isEqualTo: 'BSCL10')
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       FirebaseFirestore.instance
  //           .collection('products')
  //           .doc(element.id)
  //           .update({
  //         'stream': [],
  //         'set': [
  //           {
  //             'name': 'BookSet',
  //             'price': '1000',
  //           },
  //           {
  //             'name': 'BookSet + NoteBook Set',
  //             'price': '2000',
  //           },
  //         ],
  //       }).then((value) => print('Product updated successfully'));
  //     });
  //   });
  //
  // }
  // static ProductModel randomProductData() {

  //   return ProductModel(
  //     productId: 'BSCL1',
  //     name: 'Class 1st',
  //     description: 'All the books for Class 1 as per the curriculum. 16 notebook set as prescribed and mandatory add ons.',
  //     price: 3750,
  //     stockQuantity: 90,
  //     categoryId: 'BK',
  //     image: 'https://lh3.googleusercontent.com/d/1sDnxyoQk-fYp--UfZb5ciImfrNFSnLeM',
  //     classId: 'CLA1',
  //
  //     board: 'CBSE',
  //     salePrice: 3700,
  //     reviewIdList: [
  //
  //     ],
  //   );
  // }

  //Create a function to send this random product data to firebase in new collection named "products"
// static Future<void> sendRandomProductData() async {
//     ProductModel product = ProductModel.randomProductData();
//     await FirebaseFirestore.instance
//         .collection('products')
//         .add(product.toMap()).then((value) => {
//           print('Product added successfully')
//         }).catchError((error) => {
//           print('Failed to add product: $error')
//         });
//   }



  String toJson() => json.encode(toMap());
}