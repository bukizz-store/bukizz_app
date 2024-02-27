import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:flutter/foundation.dart';

import '../../models/ecommerce/products/product_model.dart';
import '../../models/ecommerce/products/variation/set_model.dart';
import '../../models/ecommerce/products/variation/stream_model.dart';

class ProductViewRepository extends ChangeNotifier {
  bool isProductAdded = false;

  bool get getIsProductAdded => isProductAdded;

  setProductLoaded(bool value){
    isProductAdded = value;
    notifyListeners();
  }

  List<ProductModel> productData = [];

  late ProductModel selectedProduct ;

  ProductModel get getProductDetail => selectedProduct;

  setProductDetail(ProductModel productModel){
    selectedProduct = productModel;
    notifyListeners();
  }

  String _productName = '';

  String get productName => _productName;

  setProductName(String school){
    String schoolName = school;
    String productName = selectedProduct.name;
    _productName = "$schoolName - $productName";
    notifyListeners();
  }
  int _selectedSetDataIndex = 0;

  int get getSelectedSetDataIndex => _selectedSetDataIndex;

  setSelectedSetData(int value){
    _selectedSetDataIndex = value;
    notifyListeners();
  }

  int _selectedStreamDataIndex = 0;

  int get getSelectedStreamDataIndex => _selectedStreamDataIndex;

  setSelectedStreamData(int value){
    _selectedStreamDataIndex = value;
    notifyListeners();
  }

  late var data;

  late int selectedIndex = 0;

  int get getSelectedIndex => selectedIndex;

  void setSelectedIndex(){
    selectedIndex = selectedProduct.stream.isNotEmpty ? _selectedStreamDataIndex : _selectedSetDataIndex;
    data = selectedProduct.stream.isNotEmpty ? selectedProduct.stream[_selectedStreamDataIndex] : selectedProduct.set[_selectedSetDataIndex];
    notifyListeners();
  }


  int totalSalePrice = 0;

  int get getTotalSalePrice => totalSalePrice;

  setTotalSalePrice(){
    totalSalePrice = selectedProduct.stream.isNotEmpty ? selectedProduct.stream[_selectedStreamDataIndex].salePrice: selectedProduct.set[_selectedSetDataIndex].salePrice;
    notifyListeners();
  }

  int totalPrice = 0;

  int get getTotalPrice => totalSalePrice;

  setTotalPrice(){
    totalPrice = selectedProduct.stream.isNotEmpty ? selectedProduct.stream[_selectedStreamDataIndex].price: selectedProduct.set[_selectedSetDataIndex].price;
    notifyListeners();
  }

  Future<void> getProductData(List<dynamic> productId) async {
    print(productId.toString());
    //Create a method to fetch the product data from firebase which is stored in products collection where productId is equals to the productId list which is coming from school model nd store it in productData list.
    setProductLoaded(false);
    productData = await FirebaseFirestore.instance
        .collection('products')
        .where('productId', whereIn: productId)
        .get()
        .then((value) =>
            value.docs.map((e) => ProductModel.fromMap(e.data())).toList());

    productData.sort((a, b) => compareClassIds(a.classId, b.classId));


    setProductLoaded(true);
  }
}


// Custom comparison function to sort classIds
int compareClassIds(String a, String b) {
  int aIndex = getClassIndex(a);
  int bIndex = getClassIndex(b);

  return aIndex.compareTo(bIndex);
}

// Helper function to get the index of classId
int getClassIndex(String classId) {
  // Parse the numerical part of the classId
  int numericValue = int.tryParse(classId.replaceAll(RegExp(r'\D'), '')) ?? 0;

  // Custom mapping for 10th, 11th, and 12th
  if (classId.toLowerCase().contains('10th')) {
    numericValue += 100; // Shift 10th to come after 1st to 9th
  } else if (classId.toLowerCase().contains('11th')) {
    numericValue += 200; // Shift 11th to come after 1st to 10th
  } else if (classId.toLowerCase().contains('12th')) {
    numericValue += 300; // Shift 12th to come after 1st to 11th
  }

  return numericValue;
}
