import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../models/ecommerce/products/product_model.dart';
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

  Map<String , Map<String , Map<int , Map<int , int>>>> cartData = {};

  Map<String , Map<String , Map<int , Map<int , int>>>>  get getCartData => cartData;


  Map<String , Map<String , Map<int , Map<int , int>>>> _singleCartData = {};

  Map<String , Map<String , Map<int , Map<int , int>>>>  get singleCartData => _singleCartData;

  set singleCartData(value){
    _singleCartData = value;
    notifyListeners();
  }


  void blankCart() async{
    cartData = {};
    products = [];
  }
  
  String orderName = 'BookSet';
  
  void getProductName()
  {
    if(cartData.containsKey('all'))
      {
        orderName = '$orderName + Stationary';
      }
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

  bool _isSingleBuyNow = false;

  bool get isSingleBuyNow => _isSingleBuyNow;

  set isSingleBuyNow(value){
    _isSingleBuyNow = value;
    notifyListeners();
  }

  void addProduct(ProductModel productModel) {
    if(!products.contains(productModel)){
    products.add(productModel);
    }
    notifyListeners();
  }


  void addCartData(ProductModel productModel , String schoolName ,int set , int stream, int quantity) {

    if(isSingleBuyNow){
      singleCartData.clear();
      singleCartData.putIfAbsent(schoolName, () => {});
      singleCartData[schoolName]!.putIfAbsent(productModel.productId, () => {});
      singleCartData[schoolName]![productModel.productId]!.putIfAbsent(set, () => {});
      singleCartData[schoolName]![productModel.productId]![set]!.putIfAbsent(stream, () => 0);
      singleCartData[schoolName]![productModel.productId]![set]![stream] = (singleCartData[schoolName]![productModel.productId]![set]![stream] ?? 0) + quantity;
      addProduct(productModel);
      setCartVal(1);
      print(singleCartData);
    }else{
      cartData.putIfAbsent(schoolName, () => {});
      cartData[schoolName]!.putIfAbsent(productModel.productId, () => {});
      cartData[schoolName]![productModel.productId]!.putIfAbsent(set, () => {});
      cartData[schoolName]![productModel.productId]![set]!.putIfAbsent(stream, () => 0);
      cartData[schoolName]![productModel.productId]![set]![stream] = (cartData[schoolName]![productModel.productId]![set]![stream] ?? 0) + quantity;

      addProduct(productModel);
      int length = 0;

      cartData.forEach((schoolName, productId) {
        productId.forEach((key, set) {
          length = length + set.length;
        });
      });
      setCartVal(length);
    }
    notifyListeners();
  }


  void removeCartData(String schoolName , String productId , int set, int stream){

    if(cartData[schoolName]![productId]![set]!.length == 1){
      cartData[schoolName]![productId]!.remove(set);
      if(cartData[schoolName]![productId]!.isEmpty){
        cartData[schoolName]!.remove(productId);
        if(cartData[schoolName]!.isEmpty){
          cartData.remove(schoolName);
        }
      }
    }
    else{
      cartData[schoolName]![productId]![set]!.remove(stream);
    }
    int length = 0;

    cartData.forEach((schoolName, productId) {
      productId.forEach((key, set) {
        set.forEach((key, stream) {
          length = length + stream.length;
        });
      });
    });

    setCartVal(length);
    notifyListeners();
  }

  void removeSingleCartData(String schoolName ,int set , int stream, String productId){
    // print(schoolName + " " + productId);

    if(cartData[schoolName]![productId]![set]![stream]! > 1){
      cartData[schoolName]![productId]![set]![stream] = cartData[schoolName]![productId]![set]![stream]! - 1;
    }
    else{
      cartData[schoolName]![productId]!.remove(set);
      if(cartData[schoolName]![productId]!.isEmpty){
        cartData[schoolName]!.remove(productId);
      }
    }

    // print(cartData);
    notifyListeners();
  }

  Future<void> getCartProduct(String productId , String schoolName ,int set , int stream ,  int quantity) async {
    setIsCartLoaded(false);
    // if (products.any((element) => element.productId != productId)) {
      ProductModel product = await FirebaseFirestore.instance
          .collection('products')
          .where('productId', isEqualTo: productId)
          .get()
          .then((value) => ProductModel.fromMap(value.docs.first.data()));
    addCartData(product, schoolName,set , stream , quantity);
    // }
    setIsCartLoaded(true);
    notifyListeners();
  }



}


