import 'package:bukizz/data/models/ecommerce/products/variation/variation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/ecommerce/products/general_product_model.dart';

class GeneralProductRepository extends ChangeNotifier{
  List<GeneralProductModel> generalProduct =[];

  late GeneralProductModel selectedGeneralProduct ;

  void addGeneralProduct(GeneralProductModel product){
    generalProduct.add(product);
    notifyListeners();
  }

  bool _isProductLoaded = false;

  bool get isProductLoaded => _isProductLoaded;

  set isProductLoaded(bool value) {
    _isProductLoaded = value;
    notifyListeners();
  }

  late GeneralProductModel _selectedProduct ;

  GeneralProductModel get selectedProduct => _selectedProduct;

  set selectedProduct(GeneralProductModel value) {
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
        generalProduct.add(GeneralProductModel.fromMap(element.data()));
      })
    });
    isProductLoaded = true;
    notifyListeners();
  }

  //push a random general product to the firebase
  Future<void> sendGeneralProductToFirebase()async {
    VariationGeneral variation = VariationGeneral( name: 'Black',
    image: ['https://m.media-amazon.com/images/I/71QejemtPCL._SX679_.jpg', 'https://m.media-amazon.com/images/I/71QejemtPCL._SX679_.jpg', 'https://m.media-amazon.com/images/I/61bPwPFvdqL._SX679_.jpg', 'https://m.media-amazon.com/images/I/81iUZdSsyoL._SX679_.jpg', 'https://m.media-amazon.com/images/I/81iUZdSsyoL._SX679_.jpg', 'https://m.media-amazon.com/images/I/81iUZdSsyoL._SX679_.jpg', 'https://m.media-amazon.com/images/I/714xjxj1FFL._SX679_.jpg'],
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
        productId: 'BAG101',
        name: 'Gear Elevate Faux Leather 20L Water Resistant Anti-Theft Backpack/Laptop Bag/Office Bag with RainCover for Men/Women (Black-Red)',
        description: 'Ergonomic Design : Spacious with Multiple Compartments & Pockets : Intuitive Access : Optimized Back Panel with Premium Cushioning with Airflow Mechanism : Padded & Adjustable Shoulder Straps : Padded Base : Lightweight : Bar-Tacked Load Points : Water Resistant Fabric : Heavy Duty Long Lasting Zippers : Padded Sleeve Fits Up To 15.6″ Laptop & Tab : Elasticated Trolley Sleeve on Back Panel : Concealed Anti-theft Pocket',
        brand: 'Gear',
        categoryId: 'BG',
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