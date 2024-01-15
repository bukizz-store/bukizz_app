import 'dart:convert';

import 'package:bukizz_1/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ecommerce/cart_model.dart';

class CartProvider extends ChangeNotifier {
  CartModel cartData  = CartModel(
    totalAmount: 0.0,
    productsId: {},
    address: AppConstants.userData.address,
  );

  CartModel get getCartData => cartData;

  bool _isCartLoaded = false;

  bool get isCartLoaded => _isCartLoaded;

  void setCartLoaded(bool value){
    _isCartLoaded = value;
    notifyListeners();
  }

  void addProductInCart(String productId , BuildContext context) {
    cartData.productsId[productId] = (cartData.productsId[productId] ?? 0) + 1;
    SnackBar snackBar = const SnackBar(
      content: Text('Product added to cart'),
      duration: Duration(seconds: 2),
    );
    storeCartData();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    notifyListeners();
  }

  void removeCartData(String productId) {
    if(cartData.productsId.containsKey(productId)){
      if(cartData.productsId.length >1)
        {
          cartData.productsId [productId] = (cartData.productsId [productId]! - 1);
        }
      else{
        cartData.productsId.remove(productId);
      }
      notifyListeners();
    }

    notifyListeners();
  }

  //Create function store this cart data in shared prefereances and then use it in checkout screen.
  void storeCartData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cartData', jsonEncode(cartData.toJson()));
  }

  void loadCartData() async{
    setCartLoaded(false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      if(prefs.containsKey('cartData')) {
        String? cartDataString = prefs.getString('cartData');
        if (cartDataString != null) {
          Map<String, dynamic> map = jsonDecode(cartDataString).cast<String, dynamic>();
          Map<String , int> productsIdMap = Map<String , int>.from(map['productsId']);
          cartData = CartModel(
            totalAmount: map['totalAmount'],
            productsId: productsIdMap,
            address: map['address'],
          );
        } else {
          cartData = CartModel(
            totalAmount: 0.0,
            productsId: {},
            address: AppConstants.userData.address,
          );
        }

        notifyListeners();
      }
    }
    catch(e){
      print('Error loading cart data from shared preferences: $e');
    }
    setCartLoaded(true);
  }
}