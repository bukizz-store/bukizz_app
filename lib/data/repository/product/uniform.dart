import 'package:bukizz/data/models/ecommerce/school_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/ecommerce/products/product_model.dart';

class UniformRepository extends ChangeNotifier{
  List<ProductModel> uniform = [];

  late ProductModel _selectedUniform ;

  ProductModel get selectedUniform => _selectedUniform;

  set selectedUniform(value)
  {
    _selectedUniform = value;
    notifyListeners();
  }

  bool _uniformLoaded = false;

  bool get uniformLoaded => _uniformLoaded;

  set uniformLoaded(value){
    _uniformLoaded = value;
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



  Future<void> getUniformFromFirebase(List<dynamic> uniformId)async {
    uniform.clear();
    if(uniformId.isEmpty) return;
    uniformLoaded = false;
    await FirebaseFirestore.instance.collection('products').where('productId', whereIn: uniformId).get().then((value) => {
      value.docs.forEach((element) {
        uniform.add(ProductModel.fromMap(element.data()));
      })
    });
    uniformLoaded = true;
  }
}