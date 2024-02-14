import 'package:bukizz/data/models/ecommerce/stationary/stationary_model.dart';
import 'package:bukizz/data/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StationaryProvider extends ChangeNotifier {

  bool _isStationaryLoaded = false;

  bool get isStationaryLoaded => _isStationaryLoaded;

  set isStationaryLoaded(bool value){
    _isStationaryLoaded = value;
    notifyListeners();
  }

  List<StationaryModel> _stationaryListItems = [];

  List<StationaryModel> get stationaryListItems => _stationaryListItems;

  set stationaryListItems(List<StationaryModel> value) {
    _stationaryListItems = value;
    notifyListeners();
  }

  void fetchStationaryItems(BuildContext context) async {
    isStationaryLoaded = false;
    context.read<CartProvider>().loadCartData(context).then((value) => debugPrint("Cart Data Loaded Successfully"));
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
    isStationaryLoaded = true;
    notifyListeners();
  }
}
