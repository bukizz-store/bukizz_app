import 'package:bukizz_1/data/models/ecommerce/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class StationaryProvider extends ChangeNotifier {

  bool isStationaryLoaded = false;

  bool get getIsStationaryLoaded => isStationaryLoaded;

  setStationaryLoaded(bool value){
    isStationaryLoaded = value;
    notifyListeners();
  }

  List<ProductModel> _stationaryListItems = [];

  List<ProductModel> get stationaryListItems => _stationaryListItems;

  set stationaryListItems(List<ProductModel> value) {
    _stationaryListItems = value;
    notifyListeners();
  }

  Future<void> fetchStationaryItems() async {
    setStationaryLoaded(false);
    await FirebaseFirestore.instance
        .collection('products')
        .where('categoryId', isEqualTo: 'ST')
        .get()
        .then((value) {
      List<ProductModel> stationaryList = [];
      value.docs.forEach((element) {
        stationaryList.add(ProductModel.fromMap(element.data()));
      });
      stationaryListItems = stationaryList;
    });
    setStationaryLoaded(true);
    notifyListeners();
  }
}
