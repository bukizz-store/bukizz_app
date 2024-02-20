import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:flutter/foundation.dart';

import '../models/ecommerce/products/product_model.dart';
import '../models/ecommerce/products/set_model.dart';
import '../models/ecommerce/products/stream_model.dart';

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
    String streamName =  selectedProduct.stream.isNotEmpty ?  "- ${selectedProduct.stream[_selectedStreamDataIndex].name}" ?? '' : '';
    String setName = "(${selectedProduct.set[_selectedSetDataIndex].name})" ?? '';
    _productName = "$schoolName - $productName$streamName $setName";
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

  int totalSalePrice = 0;

  int get getTotalSalePrice => totalSalePrice;

  setTotalSalePrice(){
    totalSalePrice = selectedProduct.salePrice;
    selectedProduct.set.isNotEmpty ? totalSalePrice += int.parse(selectedProduct.set[_selectedSetDataIndex].price): 0;
    selectedProduct.stream.isNotEmpty ? totalSalePrice += int.parse(selectedProduct.stream[_selectedStreamDataIndex].price ?? "0"): 0;
    notifyListeners();
  }

  int totalPrice = 0;

  int get getTotalPrice => totalSalePrice;

  setTotalPrice(){
    totalPrice = selectedProduct.price.floor();
    selectedProduct.set.isNotEmpty ? totalPrice += int.parse(selectedProduct.set[_selectedSetDataIndex].price): 0;
    selectedProduct.stream.isNotEmpty ? totalPrice += int.parse(selectedProduct.stream[_selectedStreamDataIndex].price ?? "0"): 0;
    notifyListeners();
  }

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

    mergeSort(productData , compare: (ProductModel a , ProductModel b){
      return(a.classId.toLowerCase()).compareTo(b.classId.toLowerCase());
    });

    setProductLoaded(true);
  }
}
