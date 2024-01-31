import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/data/models/ecommerce/address/address_model.dart';
import 'package:bukizz_1/data/models/ecommerce/order_model.dart';
import 'package:bukizz_1/data/providers/cart_provider.dart';
import 'package:bukizz_1/data/repository/cart_view_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class OrderViewRespository extends ChangeNotifier {
  // OrderModel orderModel = OrderModel(
  //   orderId: '',
  //   userId: AppConstants.userData.uid,
  //   orderDate: DateTime.now().toIso8601String(),
  //   totalAmount: 0,
  //   saleAmount: 0,
  //   cartData: {},
  //   address: AppConstants.userData.address,
  // );

  late OrderModel orderModel ;

  Address _userAddress = AppConstants.userData.address;

  Address get getUserAddress => _userAddress;

  void setUserAddress(Address address) {
    _userAddress = address;
    notifyListeners();
  }

  var uuid = Uuid();

  OrderModel get getOrderModel => orderModel;

  void setOrderModelData(double totalAmount, double saleAmount,
      Map<String , Map<String , Map<int , Map<int , int>>>> cartData) {
    orderModel = OrderModel(
        orderId: uuid.v1(),
        userId: AppConstants.userData.uid,
        orderDate: DateTime.now().toIso8601String(),
        totalAmount: totalAmount,
        saleAmount: saleAmount,
        cartData: cartData,
        address: getUserAddress);

    print(orderModel);
    notifyListeners();
  }

  void pushOrderDataToFirebase(BuildContext context) async{
    // try
    // {
    // print(orderModel.toMap());

    Map<String , dynamic> order = orderModel.toMap();
      await FirebaseFirestore.instance
          .collection('orderDetails')
          .doc(orderModel.orderId.toString())
          .set(order).then((value) => print("Added in Order"));
      await FirebaseFirestore.instance
          .collection('userDetails')
          .doc(AppConstants.userData.uid)
          .update({
        'orderID': FieldValue.arrayUnion([orderModel.orderId]),
      })
          .then((value) {
        context.read<CartProvider>().blankCart();
        context.read<CartViewRepository>().blankCart();
      })
          .then((value) => print('Order ID added to user details')).catchError((e)=>{print(e)});

      // SnackBar snackBar = SnackBar(content: Text('Order Placed Successfully'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      notifyListeners();
    // }
    // catch(e){
    //   print("Error in pushing data : $e");
    // }
  }
}
