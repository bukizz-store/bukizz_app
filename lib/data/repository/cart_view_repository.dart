import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../models/ecommerce/product_model.dart';
import '../providers/cart_provider.dart';

class CartViewRepository extends ChangeNotifier {
  bool isCartLoadedViewProvider = false;

  bool get getIsCartLoaded => isCartLoadedViewProvider;

  setIsCartLoaded(bool value) {
    isCartLoadedViewProvider = value;
    notifyListeners();
  }

  int totalPrice = 0;
  int salePrice = 0;

  int get getTotalPrice => totalPrice;
  int get getSalePrice => salePrice;

  void setTotalPrice(int value){
    totalPrice = value;
    notifyListeners();
  }

  void setSalePrice(int value){
    salePrice = value;
    notifyListeners();
  }

  int cart_val = 0;

  int get getCartVal => cart_val;

  void setCartVal(int value){
    cart_val = value;
    notifyListeners();
  }

  List<ProductModel> products = [];

  Map<String , Map<String , int>> cartData = {};

  Map<String , Map<String , int>>  get getCartData => cartData;

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

  void addProduct(ProductModel productModel) {
    if(!products.contains(productModel)){
    products.add(productModel);
    }
    notifyListeners();
  }


  void addCartData(ProductModel productModel , String schoolName , int quantity) {
    cartData.putIfAbsent(schoolName, () => {});
    cartData[schoolName]![productModel.productId] = (cartData[schoolName]![productModel.productId] ?? 0) + quantity;
    addProduct(productModel);
    int length = 0;

    cartData.forEach((key, value) {
      length = length + value.length;
    });

    setCartVal(length);
    notifyListeners();
  }

  void removeCartData(String schoolName , String productId ){

    if(cartData[schoolName]!.length == 1){
      // products.removeWhere((element) => element.productId == productId);
      cartData.remove(schoolName);
    }
    else{
      // products.removeWhere((element) => element.productId == productId);
      cartData[schoolName]!.remove(productId);
    }

    int length = 0;

    cartData.forEach((key, value) {
      length = length + value.length;
    });

    setCartVal(length);

    // products.removeWhere((element) => element.productId == productId);
    // cartData[schoolName]!.remove(productId);

    // products.map((e) => print(e.toString()));
    // print(cartData);
    notifyListeners();
  }

  void removeSingleCartData(String schoolName , String productId){
    if(cartData[schoolName]![productId]! > 1){
      cartData[schoolName]![productId] = cartData[schoolName]![productId]! - 1;
    }
    else{
      products.removeWhere((element) => element.productId == productId);
      cartData[schoolName]!.remove(productId);
    }
    notifyListeners();
  }

  void getCartProduct(String productId , String schoolName , int quantity) async {
    setIsCartLoaded(false);
    // if (products.any((element) => element.productId != productId)) {
      ProductModel product = await FirebaseFirestore.instance
          .collection('products')
          .where('productId', isEqualTo: productId)
          .get()
          .then((value) => ProductModel.fromMap(value.docs.first.data()));
      addCartData(product, schoolName, quantity);
    // }
    setIsCartLoaded(true);
    notifyListeners();
  }

}


