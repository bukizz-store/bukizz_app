
import 'package:bukizz_1/widgets/navigator/page_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../ui/screens/HomeView/Ecommerce/product/product_description_screen.dart';
import '../models/ecommerce/product_model.dart';

class ProductProvider extends ChangeNotifier{
  List<ProductModel> productData = [];

  late ProductModel productDetail ;

  bool isProductDataLoaded = false;

  bool get getIsProductDataLoaded => isProductDataLoaded;

  setIsProductDataLoaded(bool value){
    isProductDataLoaded = value;
    notifyListeners();
  }

  void addProductData(ProductModel productModel){
    productData.add(productModel);
    notifyListeners();
  }

  void setProductDetail(ProductModel productModel){
    setIsProductDataLoaded(false);
    productDetail = productModel;
    setIsProductDataLoaded(true);
    notifyListeners();
  }
}