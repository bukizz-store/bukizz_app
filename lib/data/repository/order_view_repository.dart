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

  List<OrderModel> orders = [];

  List<double> totalAmount = [];
  List<double> saleAmount = [];
  List<Map<String , dynamic>> cartData = [];
  int cartLength = 0;
  String orderName = '';

  List<double> get getTotalAmount => totalAmount;
  List<double> get getSaleAmount => saleAmount;
  List<Map<String , dynamic>> get getCartData => cartData;
  int get getCartLength => cartLength;
  String get getOrderName => orderName;

  set setTotalAmount(List<double> value){
    totalAmount = value;
    notifyListeners();
  }

  set setSaleAmount(List<double> value){
    saleAmount = value;
    notifyListeners();
  }

  set setCartData(List<Map<String , dynamic>> value){
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

  void setData(List<double> totalAmount, List<double> saleAmount, List<Map<String , dynamic>> orders , int cartLength , String orderName){
    setTotalAmount = totalAmount;
    setSaleAmount = saleAmount;
    setCartData = orders;
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

    for (int i = 0 ; i< cartData.length ; i++) {
      var orderModelTemp = OrderModel(
        orderId: uuid.v1(),
        userId: AppConstants.userData.uid,
        orderDate: DateTime.now().toIso8601String(),
        totalAmount: totalAmount.elementAt(i),
        saleAmount: saleAmount.elementAt(i),
        orderName: orderName,
        cartData: cartData.elementAt(i),
        address: getUserAddress,
        cartLength: 1,
        status: deliveryStatus.Ordered.toString(),
        reviewId: '',
        transactionId: transactionId,
      );

      orders.add(orderModelTemp);
    }

    orders.forEach((element) {
      print(element.toJson());
    });

    await pushOrderDataToFirebase(context);
    notifyListeners();
  }

  Future<void> pushOrderDataToFirebase(BuildContext context) async{
    try
    {
    // print(orderModel.toMap());
    // Map<String , dynamic> order = orderModel.toMap();

    orders.forEach((element) {
      FirebaseFirestore.instance
          .collection('orderDetails')
          .doc(element.orderId)
          .set(element.toMap()).then((value) => print("Added in Order")).catchError((e) {
        AppConstants.showSnackBar(context, 'Error in Placing Order');
        return ;
      });
      FirebaseFirestore.instance
          .collection('userDetails')
          .doc(AppConstants.userData.uid)
          .update({
        'orderID': FieldValue.arrayUnion([element.orderId]),
      }).then((value) => debugPrint("Delivery Added in User Model")).catchError((e){
        AppConstants.showSnackBar(context, 'Error in Placing Order');
        return ;
      });
      AppConstants.userData.orderID.add(element.orderId);
    });


    // DatabaseReference ordersRef =
    // FirebaseDatabase.instance.ref().child('orderDetails');
    //
    // ordersRef.child(orderModel.orderId).set(orderModel.toJson()).then((_) {
    //   print("Added in Order");
    // }).catchError((error) {
    //   print("Error in Placing Order: $error");
    // });


      //instead of pushing this whole data in firebase fireStore database , now i have to change it to realtime database , so that i can fetch the data in the order screen
    context.read<CartProvider>().blankCart();
    context.read<CartViewRepository>().blankCart();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userData', jsonEncode(AppConstants.userData.toJson()));
      notifyListeners();
    }
    catch(e){
      print("Error in pushing data : $e");
    }
  }
}
