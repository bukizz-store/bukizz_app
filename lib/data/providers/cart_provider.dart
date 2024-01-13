import 'package:bukizz_1/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/ecommerce/cart_model.dart';

class CartProvider extends ChangeNotifier {
  CartModel cartData  = CartModel(
    totalAmount: 0.0,
    productsId: {},
    address: AppConstants.userData.address,
  );

  void addProductInCart(String productId , BuildContext context) {
    cartData.productsId[productId] = (cartData.productsId[productId] ?? 0) + 1;
    SnackBar snackBar = const SnackBar(
      content: Text('Product added to cart'),
      duration: Duration(seconds: 2),
    );
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
}