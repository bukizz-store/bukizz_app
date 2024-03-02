
import 'dart:convert';
import 'dart:math';

import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/models/ecommerce/address/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderModel {
  String orderId;
  String userId;
  String orderDate;
  String orderName;
  double totalAmount;
  double saleAmount;
  int deliveryCharge;
  Address address;
  Map<String , dynamic> cartData;
  int cartLength;
  String status;
  String reviewId;
  String retailerId;
  String transactionId;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.orderDate,
    required this.orderName,
    required this.totalAmount,
    required this.saleAmount,
    required this.cartData,
    required this.address,
    required this.cartLength,
    required this.status,
    required this.deliveryCharge,
    required this.transactionId,
    required this.retailerId,
    this.reviewId = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'orderDate': orderDate,
      'orderName': orderName,
      'totalAmount': totalAmount,
      'saleAmount': saleAmount,
      'cartData': cartData,
      'address': address.toMap(),
      'status': status,
      'cartLength' : cartLength,
      'reviewId': reviewId,
      'transactionId' : transactionId,
      'deliveryCharge' : deliveryCharge,
      'retailerId' : retailerId,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] ?? '',
      userId: map['userId'] ?? '',
      orderDate: map['orderDate'] ?? '',
      orderName: map['orderName'] ?? '',
      totalAmount: map['totalAmount'] ?? 0,
      saleAmount: map['saleAmount'] ?? 0,
      cartLength: map['cartLength'] ?? 0,
      cartData: map['cartData'] ?? {},
      address: Address.fromMap(map['address']),
      status: map['status'] ?? deliveryStatus.Initiated.name,
      reviewId: map['reviewId'] ?? '',
      transactionId: map['transactionId'] ?? '',
      deliveryCharge: map['deliveryCharge'] ?? 0,
      retailerId: map['retailerId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(Map<String, dynamic> map) => OrderModel.fromMap(map);

  // OrderModel copyWith({
  //   String? orderId,
  //   String? userId,
  //   String? orderDate,
  //   Address? address,
  //   double? totalAmount,
  //   double? saleAmount,
  //   Map<String , Map<String , int>>? cartData,
  //
  // }) {
  //   return OrderModel(
  //     orderId: orderId ?? this.orderId,
  //     userId: userId ?? this.userId,
  //     orderDate: orderDate ?? this.orderDate,
  //     totalAmount: totalAmount ?? this.totalAmount,
  //     saleAmount: saleAmount ?? this.saleAmount,
  //     cartData: cartData ?? this.cartData,
  //     address: address ?? this.address,
  //   );
  // }

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, userId: $userId, orderName: $orderName, orderDate: $orderDate, totalAmount: $totalAmount, cartData: $cartData , address: $address , status: $status , reviewId: $reviewId , transactionId: $transactionId , deliveryCharge: $deliveryCharge , saleAmount: $saleAmount , cartLength: $cartLength)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
    other.orderId == orderId &&
    other.userId == userId &&
    other.orderDate == orderDate &&
    other.orderName == orderName &&
    other.totalAmount == totalAmount &&
    other.saleAmount == saleAmount &&
    other.cartData == cartData &&
    other.cartLength == cartLength &&
    other.address == address &&
    other.transactionId == transactionId &&
    other.reviewId == reviewId &&
    other.deliveryCharge == deliveryCharge &&
    other.status == status;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
    userId.hashCode ^
    orderDate.hashCode ^
    totalAmount.hashCode ^
    orderName.hashCode ^
    saleAmount.hashCode ^
    address.hashCode ^
    cartLength.hashCode ^
    status.hashCode ^
    reviewId.hashCode ^
    transactionId.hashCode ^
    deliveryCharge.hashCode ^
    cartData.hashCode;

  }

  static OrderModel fromSnapshot(DocumentSnapshot snap) {
    return OrderModel(
      orderId: snap['orderId'],
      userId: snap['userId'],
      orderDate: snap['orderDate'],
      orderName: snap['orderName'],
      totalAmount: snap['totalAmount'],
      saleAmount: snap['saleAmount'],
      cartData: snap['cartData'],
      cartLength: snap['cartLength'],
      status: snap['status'],
      reviewId: snap['reviewId'],
      transactionId: snap['transactionId'],
      address: Address.fromMap(snap['address']),
      deliveryCharge: snap['deliveryCharge'],
      retailerId: snap['retailerId'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'orderId': orderId,
      'userId': userId,
      'orderDate': orderDate,
      'totalAmount': totalAmount,
      'saleAmount': saleAmount,
      'cartData': cartData,
      'orderName': orderName,
      'cartLength': cartLength,
      'status': status,
      'address': address,
      'reviewId': reviewId,
      'transactionId': transactionId,
      'deliveryCharge': deliveryCharge,
    };
  }

  //Method to add a field in all the order data in the firebase in collection orderDetails
  // static Future<void> addFieldInOrderData() async {
  //   await FirebaseFirestore.instance
  //       .collection('orderDetails').get().then((value) =>
  //       value.docs.forEach((element) {
  //         FirebaseFirestore.instance
  //             .collection('orderDetails')
  //             .doc(element.id)
  //             .update({'deliveryCharge': Random().nextInt(100), 'retailerId': ''}).then((value) => debugPrint('Field added'));
  //       }));
  // }
}

