import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/ecommerce/categoryModel.dart';

class CategoryRepository extends ChangeNotifier{
  List<CategoryModel> category =[];

  late CategoryModel selectedCategory ;

  void addCategory(CategoryModel categoryModel){
    category.add(categoryModel);
    notifyListeners();
  }

  bool _isCategoryLoaded = false;

  bool get isCategoryLoaded => _isCategoryLoaded;

  set isCategoryLoaded(bool value) {
    _isCategoryLoaded = value;
    notifyListeners();
  }

  Future<void> getCategoryFromFirebase() async{
    category = [];
    await FirebaseFirestore.instance.collection('category').get().then((value) => {
      value.docs.forEach((element) {
        category.add(CategoryModel.fromMap(element.data()));
      })
    });
    category.sort((a, b) => a.name.compareTo(b.name));
  }

  Future<void> pushCategoryData() async{
    CategoryModel categoryModel = CategoryModel(
      categoryId: "Stationary Kit",
      name: 'Stationary Kit',
      image: 'https://m.media-amazon.com/images/I/71ZwHhBuKPL._SL1500_.jpg',
      description: 'This is the category for all the Stationary items',
      offers: "25% off",
    );

    await FirebaseFirestore.instance.collection('category').add(categoryModel.toMap()).then((value) => {
      print('Category added')
    });

  }
}