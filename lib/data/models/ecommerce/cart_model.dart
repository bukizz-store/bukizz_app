
import 'dart:convert';

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
      'address': address,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      totalAmount: map['totalAmount'] ?? 0.0,
      productsId: map['products'] ?? {},
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}