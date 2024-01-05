import 'dart:convert';

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
    );
  }

  String toJson() => json.encode(toMap());
}