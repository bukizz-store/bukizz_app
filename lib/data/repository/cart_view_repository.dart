import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/ecommerce/product_model.dart';

class CartViewRepository extends ChangeNotifier {
  bool isCartLoaded = false;

  bool get getIsCartLoaded => isCartLoaded;

  setIsCartLoaded(bool value) {
    isCartLoaded = value;
    notifyListeners();
  }

  List<ProductModel> products = [];

  void addProduct(ProductModel productModel) {
    products.add(productModel);
    notifyListeners();
  }

  void getCartProduct(String productId) async {
    setIsCartLoaded(false);
      ProductModel product = await FirebaseFirestore.instance
          .collection('products')
          .where('productId', isEqualTo: productId)
          .get()
          .then((value) => ProductModel.fromMap(value.docs.first.data()));
      addProduct(product);
    setIsCartLoaded(true);
  }
}
