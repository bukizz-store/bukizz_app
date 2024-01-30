import 'dart:convert';
import 'package:bukizz_1/data/repository/cart_view_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../models/ecommerce/cart_model.dart';
import '../models/ecommerce/products/product_model.dart';

class CartProvider extends ChangeNotifier {
  // Map<SchoolName , Map<productId , Map<set , Map<stream , quantity>>>>

  Map<String , Map<String , Map<int , Map<int , int>>>> cartData = {};

  Map<String , Map<String , Map<int , Map<int , int>>>> get getCartData => cartData;

  // CartModel get getCartData => cartData;

  bool _isCartLoadedProvider = false;

  bool get isCartLoadedProvider => _isCartLoadedProvider;

  void setCartLoaded(bool value){
    _isCartLoadedProvider = value;
    notifyListeners();
  }

  void addProductInCart(String schoolName,int set , int stream , int quantity, String productId, BuildContext context) async {
    setCartLoaded(false);

    cartData.putIfAbsent(schoolName, () => {});
    // cartData[schoolName]![productId] = (cartData[schoolName]![productId] ?? 0) + quantity;
    cartData[schoolName]!.putIfAbsent(productId, () => {});
    cartData[schoolName]![productId]!.putIfAbsent(set, () => {});
    cartData[schoolName]![productId]![set]!.putIfAbsent(stream, () => 0);
    cartData[schoolName]![productId]![set]![stream] = (cartData[schoolName]![productId]![set]![stream] ?? 0) + quantity;

    print(cartData);
    context.read<CartViewRepository>().getCartProduct(productId, schoolName ,set , stream ,  quantity);

    await storeCartData();

    const snackBar = SnackBar(
      content: Text('Product added to cart'),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setCartLoaded(true);
    notifyListeners();
  }

  void removeCartData(String schoolName, String productId , int set , int stream, BuildContext context) async{

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

    const snackBar = SnackBar(
      content: Text('Product removed from cart'),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    await storeCartData();
    // If the product is not in the cart, you might want to handle this case

    // Notify listeners after updating the cart data
    notifyListeners();
  }

  void removeSingleCartData(String schoolName , String productId , BuildContext context ,int set , int stream, int quantity) async{

    if(cartData[schoolName]![productId]![set]![stream]! > 1){
      cartData[schoolName]![productId]![set]![stream] = cartData[schoolName]![productId]![set]![stream]! - 1;
    }
    else{
      cartData[schoolName]![productId]![set]!.remove(stream);
      if(cartData[schoolName]![productId]![set]!.isEmpty){
        cartData[schoolName]![productId]!.remove(set);
        if(cartData[schoolName]![productId]!.isEmpty){
          cartData[schoolName]!.remove(productId);
        }
      }
    }

    print(cartData);
    context.read<CartViewRepository>().removeSingleCartData(schoolName, set , stream, productId);
    await storeCartData();
    notifyListeners();
  }

  //Create function store this cart data in shared prefereances and then use it in checkout screen.
  Future<void> storeCartData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Create a function to store this cartData in form of string in shared prefereances which can be restored easily.
    Map<String, dynamic> encodedData = {};

    cartData.forEach((school, schoolData) {
      encodedData[school] = {};
      schoolData.forEach((product, productData) {
        encodedData[school]![product] = {};
        productData.forEach((set, setData) {
          encodedData[school]![product]![set.toString()] = {};
          setData.forEach((stream, streamData) {
            encodedData[school]![product]![set.toString()]![stream.toString()] = streamData;
          });
        });
      });
    });
    // cartData.forEach((schoolName, productData) {productData.forEach((product, setData) {setData.forEach((set, streamData) {print(jsonEncode(streamData));});});});
    await prefs.setString('cartData', jsonEncode(encodedData)).then((value) => print('Cart data stored successfully'));
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
          String? cartDataString = prefs.getString('cartData');
          if (cartDataString != '' && cartDataString != null) {
            // print("Shivam");
            Map<String, dynamic> map = jsonDecode(cartDataString);
            Map<String , Map<String , Map<int , Map<int , int>>>> productsIdMap = {};

            map.forEach((school, schoolData) {
              productsIdMap[school] = {};
              schoolData.forEach((product, productData) {
                productsIdMap[school]![product] = {};
                productData.forEach((key1, innerMap) {
                  productsIdMap[school]![product]![int.parse(key1)] = {};
                  innerMap.forEach((key2, value) {
                    productsIdMap[school]![product]![int.parse(key1)]![int.parse(key2)] = value;
                    context.read<CartViewRepository>().getCartProduct(product, school , key1 , key2 ,  value);
                  });
                });
              });
            });

            cartData = productsIdMap;
            print(cartData);
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