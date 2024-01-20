import 'dart:convert';

import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/data/repository/cart_view_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../models/ecommerce/cart_model.dart';
import '../models/ecommerce/product_model.dart';

class CartProvider extends ChangeNotifier {
  // Map<SchoolName , Map<productId , quantity>>

  Map<String , Map<String , int>> cartData = {};

  Map<String , Map<String , int>> get getCartData => cartData;

  // CartModel get getCartData => cartData;

  bool _isCartLoadedProvider = false;

  bool get isCartLoadedProvider => _isCartLoadedProvider;

  void setCartLoaded(bool value){
    _isCartLoadedProvider = value;
    notifyListeners();
  }

  // void setCartData(String schoolName , int quantity , String productId){
  //   cartData[schoolName] = CartValue(productId: productId , quantity: quantity);
  //   // print(cartData.toString());
  //   cartData.forEach((key, value){
  //     // print(key);
  //     // print(value.productId);
  //     // print(value.quantity);
  //   });
  //   notifyListeners();
  // }


//   void addProductInCart(String schoolName , int quantity , String productId, BuildContext context) async{
//     setCartLoaded(false);
//
//     if(cartData.containsKey(schoolName)){
//       // cartData.productsId[productId] = (cartData.productsId[productId]! + 1);
//       if(cartData[schoolName]!.containsKey(productId))
//         {
// cartData[schoolName]! [productId] = (cartData[schoolName]! [productId]! + quantity);
//         }
//       else{
//         cartData[schoolName]! [productId] = quantity;
//       }
//       // cartData[schoolName]![productId] = (cartData[schoolName]![productId]! + 1);
//     }
//     else{
//       // cartData.productsId[productId] = 1;
//       cartData[schoolName] = {productId : quantity};
//       // context.read<CartViewRepository>().getCartProduct(productId);
//     }
//
//     print(cartData);
//     // cartData.productsId[productId] = (cartData.productsId[productId] ?? 0) + 1;
//     SnackBar snackBar = const SnackBar(
//       content: Text('Product added to cart'),
//       duration: Duration(seconds: 2),
//     );
//
//
//
//     // await storeCartData();
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     setCartLoaded(true);
//     notifyListeners();
//   }

  void addProductInCart(String schoolName, int quantity, String productId, BuildContext context) async {
    setCartLoaded(false);

    cartData.putIfAbsent(schoolName, () => {});
    cartData[schoolName]![productId] = (cartData[schoolName]![productId] ?? 0) + quantity;

    // print(cartData);
    context.read<CartViewRepository>().getCartProduct(productId, schoolName , quantity);
    await storeCartData();

    final snackBar = SnackBar(
      content: const Text('Product added to cart'),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setCartLoaded(true);
    notifyListeners();
  }
  void removeCartData(String schoolName, String productId) async{
    if (cartData.containsKey(schoolName)) {
      if (cartData[schoolName]!.containsKey(productId)) {
        // Decrease the quantity by 1
        cartData[schoolName]![productId] = (cartData[schoolName]![productId]! - 1);

        // If the quantity becomes 0, remove the product from the cart
        if (cartData[schoolName]![productId] == 0) {
          cartData[schoolName]!.remove(productId);
        }
      }

      await storeCartData();
      // If the product is not in the cart, you might want to handle this case

      // Notify listeners after updating the cart data
      notifyListeners();
    }
  }

  //Create function store this cart data in shared prefereances and then use it in checkout screen.
  Future<void> storeCartData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Create a function to store this cartData in form of string in shared prefereances which can be restored easily.

    await prefs.setString('cartData', jsonEncode(cartData)).then((value) => print('Cart data stored successfully'));
    print(prefs.getString('cartData'));
  }
  //
  void loadCartData(BuildContext context) async{
    await Future.delayed(Duration.zero, () {
      setCartLoaded(false);
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(cartData.isEmpty) {
      try {
        if (prefs.containsKey('cartData')) {
          print(prefs.getString('cartData'));
          String? cartDataString = prefs.getString('cartData');
          if (cartDataString != '' && cartDataString != null) {
            // print("Shivam");
            Map<String, dynamic> map = jsonDecode(cartDataString);
            Map<String , Map<String , int>> productsIdMap =
               map.map((key, value) => MapEntry(key, Map<String , int>.from(value)));
            cartData = productsIdMap;
            // print(cartData.toMap().toString());


            productsIdMap.forEach((schoolName, productData) {
              productData.forEach((productId, quantity) {
                context.read<CartViewRepository>().getCartProduct( productId ,schoolName,  quantity);
              });
            });


          }

          notifyListeners();
        }
      } catch (e) {
        print('Error loading cart data from shared preferences: $e');
      }
    }
    await Future.delayed(Duration.zero, () {
      setCartLoaded(true);
    });
  }
}

class CartValue{
  String productId;
  int quantity;

  CartValue({required this.productId , required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory CartValue.fromMap(Map<String, dynamic> map) {
    return CartValue(
      productId: map['productId'] ?? '',
      quantity: map['quantity'] ?? 0,
    );
  }

  factory CartValue.fromJson(Map<String, dynamic> map) => CartValue.fromMap(map);

  String toJson() => json.encode(toMap());
}