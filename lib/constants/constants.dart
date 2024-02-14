import 'package:flutter/material.dart';

import '../data/models/user_details.dart';

enum userType{
  student, teacher
}

enum deliveryStatus{
  Ordered , Shipped , Delivered
}

class AppConstants{
  static late MainUserDetails userData ;
  static bool isLogin = false;
  static List<String> locationSet = [];

  static buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static Future<void> showSnackBar(BuildContext context , String text) async {
    var snackBar = SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}

