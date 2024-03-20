import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/models/ecommerce/products/product_model.dart';
import 'package:bukizz/data/models/ecommerce/products/variation/variation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/ecommerce/products/general_product_model.dart';

class GeneralProductRepository extends ChangeNotifier{
  List<ProductModel> generalProduct =[];

  late ProductModel selectedGeneralProduct ;

  void addGeneralProduct(ProductModel product){
    generalProduct.add(product);
    notifyListeners();
  }

  bool _isProductLoaded = false;

  bool get isProductLoaded => _isProductLoaded;

  set isProductLoaded(bool value) {
    _isProductLoaded = value;
    notifyListeners();
  }

  late ProductModel _selectedProduct ;

  ProductModel get selectedProduct => _selectedProduct;

  set selectedProduct(ProductModel value) {
    _selectedProduct = value;
    notifyListeners();
  }

  int _selectedVariationIndex= 0;

  int get selectedVariationIndex => _selectedVariationIndex;

  set selectedVariationIndex(int value) {
    _selectedVariationIndex = value;
    notifyListeners();
  }

  Future<void> getGeneralProductFromFirebase(String categoryId)async {
    isProductLoaded = false;
    generalProduct.clear();
    await FirebaseFirestore.instance.collection('generalProduct').where('categoryId' , isEqualTo: categoryId).get().then((value) => {
      value.docs.forEach((element) {
        var data = ProductModel.fromGeneralMap(element.data());
        if(data.city.contains(AppConstants.location))
          {
            generalProduct.add(data);
          }
      })
    });
    isProductLoaded = true;
  }

  //push a random general product to the firebase
  Future<void> sendGeneralProductToFirebase()async {
    VariationGeneral variation = VariationGeneral( name: 'Black',
    image: ['https://m.media-amazon.com/images/I/81hMj8os7XL._SX679_.jpg', ],
    sku: 10,
    salePrice: 1995,
    reviewIdList: [],
    price: 3999);
        VariationGeneral variation2 = VariationGeneral( name: 'Navy-Mint',
    image: ['https://m.media-amazon.com/images/I/71QdeRfCY7L._SX679_.jpg', 'https://m.media-amazon.com/images/I/715UJa9Qb8L._SX679_.jpg', 'https://m.media-amazon.com/images/I/61gSn4-D0iL._SX679_.jpg', 'https://m.media-amazon.com/images/I/81uGlJQGE9L._SX679_.jpg', 'https://m.media-amazon.com/images/I/81pM3YubT-L._SX679_.jpg', 'https://m.media-amazon.com/images/I/71yg8lhm+HL._SX679_.jpg', 'https://m.media-amazon.com/images/I/71Krs7yoHqL._SX679_.jpg'],
    sku: 10,
    salePrice: 1995,
    reviewIdList: [],
    price: 3999);

      GeneralProductModel product = GeneralProductModel(
        productId: 'Stationary101',
        name: 'Apsara Kit, Premium 14 Color Pencils, 24 Wax Crayons, Skater Sparkle Gel Pen, Premium Dark Pencils, Briefcase Shaped Pack For Convenient Storage, Fun Kit For Children, Multicolor',
        description:'MY APSARA KIT: My Apsara Kit is a Comprehensive Stationery Collection Perfect for Back-to-school Needs. It Includes Premium Color Pencils, Wax Crayons, a Sparkling Gel Pen, Dark Pencils, Erasers, and a Scale, Offering a Complete Set of High-quality Tools for Students and Creative Individuals.',
        brand: 'Apsara',
        categoryId: 'Stationary Kit',
        relatilerId: '1',
        variation: [
          variation,
          variation2
        ],
      );
      await FirebaseFirestore.instance.collection('generalProduct').add(product.toMap()).then((value) => {
        print('Product added successfully')
      });
  }
}