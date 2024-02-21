import 'dart:convert';

import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/models/ecommerce/address/address_model.dart';
import 'package:bukizz/data/models/ecommerce/order_model.dart';
import 'package:bukizz/data/models/user_details.dart';
import 'package:bukizz/data/providers/cart_provider.dart';
import 'package:bukizz/data/repository/cart_view_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class OrderViewRespository extends ChangeNotifier {
  OrderModel orderModel = OrderModel(
    orderId: '',
    userId: AppConstants.userData.uid,
    orderDate: DateTime.now().toIso8601String(),
    orderName: '',
    totalAmount: 0,
    saleAmount: 0,
    cartData: {},
    cartLength: 0,
    address: AppConstants.userData.address,
    status: deliveryStatus.Ordered.toString(),
    reviewId: '',
    transactionId: '',
  );

  double totalAmount = 0;
  double saleAmount = 0;
  Map<String , dynamic> cartData = {};
  int cartLength = 0;
  String orderName = '';

  double get getTotalAmount => totalAmount;
  double get getSaleAmount => saleAmount;
  Map<String , dynamic> get getCartData => cartData;
  int get getCartLength => cartLength;
  String get getOrderName => orderName;

  set setTotalAmount(double value){
    totalAmount = value;
    notifyListeners();
  }

  set setSaleAmount(double value){
    saleAmount = value;
    notifyListeners();
  }

  set setCartData(Map<String , dynamic> value){
    cartData = value;
    notifyListeners();
  }

  set setCartLength(int value){
    cartLength = value;
    notifyListeners();
  }

  set setOrderName(String value){
    orderName = value;
    notifyListeners();
  }

  void setData(double totalAmount, double saleAmount, Map<String , dynamic> cartData , int cartLength , String orderName){
    setTotalAmount = totalAmount;
    setSaleAmount = saleAmount;
    setCartData = cartData;
    setCartLength = cartLength;
    setOrderName = orderName;

    notifyListeners();
  }

  Address _userAddress = AppConstants.userData.address;

  Address get getUserAddress => _userAddress;

  void setUserAddress(Address address) {
    _userAddress = address;
    notifyListeners();
  }

  var uuid = const Uuid();

  OrderModel get getOrderModel => orderModel;

  void setOrderModelData(String transactionId , BuildContext context) async{

    orderModel = OrderModel(
        orderId: uuid.v1(),
        userId: AppConstants.userData.uid,
        orderDate: DateTime.now().toIso8601String(),
        totalAmount: totalAmount,
        saleAmount: saleAmount,
        orderName: orderName,
        cartData: cartData,
        address: getUserAddress,
        cartLength: cartLength,
        status: deliveryStatus.Ordered.toString(),
        reviewId: '',
      transactionId: transactionId,
    );

    await pushOrderDataToFirebase(context);
    notifyListeners();
  }

  Future<void> pushOrderDataToFirebase(BuildContext context) async{
    try
    {
    // print(orderModel.toMap());
    Map<String , dynamic> order = orderModel.toMap();
      FirebaseFirestore.instance
          .collection('orderDetails')
          .doc(orderModel.orderId)
          .set(order).then((value) => print("Added in Order")).catchError((e) => {AppConstants.showSnackBar(context, 'Error in Placing Order')});

    // DatabaseReference ordersRef =
    // FirebaseDatabase.instance.ref().child('orderDetails');
    //
    // ordersRef.child(orderModel.orderId).set(orderModel.toJson()).then((_) {
    //   print("Added in Order");
    // }).catchError((error) {
    //   print("Error in Placing Order: $error");
    // });

      FirebaseFirestore.instance
          .collection('userDetails')
          .doc(AppConstants.userData.uid)
          .update({
        'orderID': FieldValue.arrayUnion([orderModel.orderId]),
      }).then((value) => debugPrint('Order ID added to user details')).catchError((e)=>{AppConstants.showSnackBar(context, 'Error in Placing Order')});


      //instead of pushing this whole data in firebase fireStore database , now i have to change it to realtime database , so that i can fetch the data in the order screen


    context.read<CartProvider>().blankCart();
    context.read<CartViewRepository>().blankCart();
      AppConstants.userData.orderID.add(orderModel.orderId);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userData', jsonEncode(AppConstants.userData.toJson()));
      AppConstants.showSnackBar(context, 'Order Placed Successfully');
      notifyListeners();
    }
    catch(e){
      print("Error in pushing data : $e");
    }
  }
}
