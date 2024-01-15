import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/ecommerce/product_model.dart';

class ProductViewRepository extends ChangeNotifier {
  bool isProductAdded = false;

  bool get getIsProductAdded => isProductAdded;

  setProductLoaded(bool value){
    isProductAdded = value;
    notifyListeners();
  }

  List<ProductModel> productData = [];

  Future<void> getProductData(List<dynamic> productId) async {
    print(productId.toString());
    //Create a method to fetch the product data from firebase whch is stored in products collection where productId is equals to the productId list which is coming from school model nd store it in productData list.
    setProductLoaded(false);
    productData = await FirebaseFirestore.instance
        .collection('products')
        .where('productId', whereIn: productId)
        .get()
        .then((value) =>
            value.docs.map((e) => ProductModel.fromMap(e.data())).toList());
    setProductLoaded(true);
  }
}
