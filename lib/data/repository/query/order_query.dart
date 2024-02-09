import 'package:bukizz/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../models/ecommerce/query/order_queryModel.dart';

class OrderQueryRepository extends ChangeNotifier {
  var uuid = const Uuid();
  OrderQuery orderQuery = OrderQuery(
    queryId: '',
    userId: '',
    query: '',
    contactNo: '',
    queryType: '',
    email: '',
    orderId: '',
    productName: '',
    dateTime: '',
  );

  String _orderId = '';
  String _productName = '';
  String _set = '';
  String _stream = '';
  String _contactNo = '';

  // Getters
  String get orderId => _orderId;
  String get productName => _productName;
  String get set => _set;
  String get stream => _stream;
  String get contactNo => _contactNo;

  // Setters
  set orderId(String value) {
    _orderId = value;
  }

  set productName(String value) {
    _productName = value;
  }

  set set(String value) {
    _set = value;
  }

  set stream(String value) {
    _stream = value;
  }

  set contactNo(String value) {
    _contactNo = value;
  }


  void setInitialData(String orderId,
      String productName, String contactNo )
  {
    this.orderId = orderId;
    this.productName = productName;
    this.set = set;
    this.stream = stream;
    this.contactNo = contactNo;

    notifyListeners();
  }

  void setOrderQuery(String query, String queryType, BuildContext context) async{
    orderQuery = OrderQuery(
        queryId: uuid.v1(),
        userId: AppConstants.userData.uid,
        query: query,
        contactNo: contactNo,
        queryType: queryType,
        email: AppConstants.userData.email,
        orderId: orderId,
        productName: productName,
        dateTime: DateTime.now().toIso8601String(),
    );
    await pushDataToFirebase(context);
    notifyListeners();
  }

  Future<void> pushDataToFirebase(BuildContext context) async
  {
    await FirebaseFirestore.instance.collection('orderQuery').doc(orderQuery.queryId).set(orderQuery.toMap()).then((value) => print("Query Added"));
    if(context.mounted)
      {
        AppConstants.showSnackBar(context, "Query Raised Successfully");
        Navigator.of(context).pop();
      }
    orderQuery = OrderQuery(queryId: '', userId: '', query: '', contactNo: '', queryType: '', email: '', orderId: '', productName: '', dateTime: '');

    notifyListeners();
  }
}
