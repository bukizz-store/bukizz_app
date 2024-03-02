import 'package:bukizz/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/ecommerce/order_model.dart';
import '../models/ecommerce/products/product_model.dart';

class MyOrders with ChangeNotifier {
  List<OrderModel> orders = [];

  List<OrderModel> get getOrders => orders;

  void setOrders(List<OrderModel> value) {
    orders = value;
    notifyListeners();
  }

  bool _isOrdersLoaded = false;

  bool get isOrdersLoaded => _isOrdersLoaded;

  void setIsOrdersLoaded(bool value) {
    _isOrdersLoaded = value;
    notifyListeners();
  }

  late OrderModel _selectedOrderModel;

  OrderModel get selectedOrderModel => _selectedOrderModel;

  set selectedOrderModel(value) {
    _selectedOrderModel = value;
    notifyListeners();
  }

  int cartLength = 0;

  int get getCartLength => cartLength;

  set setCartLength(value) {
    cartLength = value;
    notifyListeners();
  }

  // Map<SchoolName , Map<productId , Map<set , Map<stream , quantity>>>>
  Map<String, Map<String, Map<String, Map<String, List<dynamic>>>>>
  selectedOrder = {};

  void setOrder(int index) {
    selectedOrderModel = orders[index];
    Map<String, Map<String, Map<String, Map<String, List<dynamic>>>>>
    productsIdMap = {};
    selectedOrderModel.cartData.forEach((school, schoolData) {
      productsIdMap[school] = {};
      schoolData.forEach((product, productData) {
        productsIdMap[school]![product] = {};
        productData.forEach((key1, innerMap) {
          productsIdMap[school]![product]![key1] = {};
          innerMap.forEach((key2, value) {
            productsIdMap[school]![product]![key1]![key2] = value;
            setCartLength = value[0];
            getCartProduct(product, school, key1, key2, value);
          });
        });
      });
    });
    selectedOrder = productsIdMap;
    notifyListeners();
  }

  String image = '';

  String get getImage => image;

  set setImage(String value){
    image = value;
  }

  bool _isOrderDataLoaded = false;

  bool get isOrderDataLoaded => _isOrderDataLoaded;

  void setIsOrderDataLoaded(bool value) {
    _isOrderDataLoaded = value;
    notifyListeners();
  }

  void getCartProduct(String productId, String schoolName, String set,
      String stream, List<dynamic> quantity) async {
    setIsOrderDataLoaded(false);
    // if (products.any((element) => element.productId != productId)) {
    switch (stream) {
      case 'null':
        ProductModel product = await FirebaseFirestore.instance
            .collection('generalProduct')
            .where('productId', isEqualTo: productId)
            .get()
            .then((value) =>
            ProductModel.fromGeneralMap(value.docs.first.data()));
        addCartData(product);
        break;
      default:
        ProductModel product = await FirebaseFirestore.instance
            .collection('products')
            .where('productId', isEqualTo: productId)
            .get()
            .then((value) => ProductModel.fromMap(value.docs.first.data()));
        addCartData(product);
        break;
    }
    // ProductModel product = await FirebaseFirestore.instance
    //     .collection('products')
    //     .where('productId', isEqualTo: productId)
    //     .get()
    //     .then((value) => ProductModel.fromMap(value.docs.first.data()));
    // addCartData(product);
    // }
    setIsOrderDataLoaded(true);
    notifyListeners();
  }

  List<ProductModel> orderedProduct = [];

  void addProduct(ProductModel productModel) {
    if (!orderedProduct.contains(productModel)) {
      orderedProduct.add(productModel);
    }
    notifyListeners();
  }

  void addCartData(ProductModel productModel) {
    addProduct(productModel);
    int length = 0;
    notifyListeners();
  }

  //Create a method to fetch data of orders from firebase with having the docs as the user have placed the order
  // and then set the orders list with the fetched data
  Future<void> fetchOrders() async {
    print(AppConstants.userData.orderID);
    if (AppConstants.userData.orderID.isEmpty) {
      setIsOrdersLoaded(true);
      return;
    }
    setIsOrdersLoaded(false);
    List<OrderModel> tempOrders = [];
    await FirebaseFirestore.instance
        .collection('orderDetails')
        .where('orderId', whereIn: AppConstants.userData.orderID)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          tempOrders.add(OrderModel.fromMap(element.data()));
          print(element.data());
          // Map<String, dynamic> map = element.data()['cartData'];
        });
      }
    });
    tempOrders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
    setOrders(tempOrders);
    setIsOrdersLoaded(true);
    notifyListeners();
  }


}
