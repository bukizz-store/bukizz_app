
import 'dart:convert';

class CartModel{
  String cartId;
  String userId;
  double totalAmount;
  List<String> products;

  CartModel({
    required this.cartId,
    required this.userId,
    required this.totalAmount,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      'cartId': cartId,
      'userId': userId,
      'totalAmount': totalAmount,
      'products': products,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cartId: map['cartId'] ?? '',
      userId: map['userId'] ?? '',
      totalAmount: map['totalAmount'] ?? 0.0,
      products: List<String>.from(map['products'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());
}