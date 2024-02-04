import 'package:bukizz/data/models/ecommerce/stationary/stationary_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class StationaryProvider extends ChangeNotifier {

  bool isStationaryLoaded = false;

  bool get getIsStationaryLoaded => isStationaryLoaded;

  setStationaryLoaded(bool value){
    isStationaryLoaded = value;
    notifyListeners();
  }

  List<StationaryModel> _stationaryListItems = [];

  List<StationaryModel> get stationaryListItems => _stationaryListItems;

  set stationaryListItems(List<StationaryModel> value) {
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
      List<StationaryModel> stationaryList = [];
      value.docs.forEach((element) {
        stationaryList.add(StationaryModel.fromMap(element.data()));
      });
      stationaryListItems = stationaryList;
    });
    setStationaryLoaded(true);
    notifyListeners();
  }
}
