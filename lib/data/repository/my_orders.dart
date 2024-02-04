import 'package:bukizz/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/ecommerce/order_model.dart';

class MyOrders with ChangeNotifier{
  List<OrderModel> orders = [];

  List<OrderModel> get getOrders => orders;

  void setOrders(List<OrderModel> value) {
    orders = value;
    notifyListeners();
  }

  bool _isOrdersLoaded = false;

  bool get isOrdersLoaded => _isOrdersLoaded;

  void setIsOrdersLoaded(bool value) {
    _isOrdersLoaded = value;
    notifyListeners();
  }


  //Create a method to fetch data of orders from firebase with having the docs as the user have placed the order
  // and then set the orders list with the fetched data
  void fetchOrders() async {
    setIsOrdersLoaded(false);
    List<OrderModel> tempOrders = [];
    await FirebaseFirestore.instance.collection('orderDetails').where('orderId' , whereIn: AppConstants.userData.orderID).get().then((value) {
      value.docs.forEach((element) {
        tempOrders.add(OrderModel.fromMap(element.data()));
      });
    });
    setOrders(tempOrders);
    setIsOrdersLoaded(true);
    notifyListeners();
  }
}