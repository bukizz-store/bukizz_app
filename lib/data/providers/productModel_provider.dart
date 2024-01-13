import 'package:flutter/foundation.dart';

import '../models/ecommerce/product_model.dart';

class ProductProvider extends ChangeNotifier{
  List<ProductModel> productData = [];

  late ProductModel productDetail ;

  void addProductData(ProductModel productModel){
    productData.add(productModel);
    notifyListeners();
  }

  void setProductDetail(ProductModel productModel){
    productDetail = productModel;
    notifyListeners();
  }
}