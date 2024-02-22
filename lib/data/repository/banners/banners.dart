import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../../models/ecommerce/banners/banners_model.dart';

class BannerRepository extends ChangeNotifier{
  
  List<BannerModel> _banners1 = [];
  
  List<BannerModel> get banners1 => _banners1;
  
  set banners1(value){
    _banners1 = value;
    notifyListeners();
  }

  List<BannerModel> _banners2 = [];

  List<BannerModel> get banners2 => _banners2;

  set banners2(value){
    _banners2 = value;
    notifyListeners();
  }

  void getbanner1() async{
    var data = FirebaseDatabase.instance.ref().child("banners").child("slider1").get();
    data.then((DataSnapshot snapshot){
      // var temp = jsonDecode(snapshot.children.first.children.first.value.toString());
      for (var value1 in snapshot.children) {
        // debugPrint(value1.children.indexed);
        // _banners1.add(BannerModel(image: value1.value.toString(), link: value1..toString()))
      }

      debugPrint(snapshot.children.first.children.first.value.toString());
    });
  }
}