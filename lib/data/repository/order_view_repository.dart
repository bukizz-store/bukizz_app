import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/data/models/ecommerce/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class OrderViewRespository extends ChangeNotifier {
  OrderModel orderModel = OrderModel(
    orderId: '',
    userId: AppConstants.userData.uid,
    orderDate: DateTime.now().toIso8601String(),
    totalAmount: 0,
    saleAmount: 0,
    cartData: {},
    address: '',
  );

  String _userAddress = AppConstants.userData.address;

  String get getUserAddress => _userAddress;

  void setUserAddress(String address){
    _userAddress = address;
    notifyListeners();
  }




  var uuid = Uuid();

  OrderModel get getOrderModel => orderModel;

  void setOrderModelData(double totalAmount , double saleAmount , Map<String , Map<String , int>> cartData ){
    orderModel = OrderModel(
      orderId: uuid.v1(),
      userId: AppConstants.userData.uid,
      orderDate: DateTime.now().toIso8601String(),
      totalAmount: totalAmount,
      saleAmount: saleAmount,
      cartData: cartData,
      address: _userAddress
    );
    notifyListeners();
  }

  void pushOrderDataToFirebase(BuildContext context){
    FirebaseFirestore.instance.collection('orderDetails').doc(orderModel.orderId).set(orderModel.toMap());
    FirebaseFirestore.instance.collection('userDetails').doc(AppConstants.userData.uid).update({
      'orderID' : FieldValue.arrayUnion([orderModel.orderId]),
    }).then((value) => print('Order ID added to user details'));

    SnackBar snackBar = SnackBar(content: Text('Order Placed Successfully'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    notifyListeners();
  }
}