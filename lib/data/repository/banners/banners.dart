import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../../models/ecommerce/banners/banners_model.dart';

class BannerRepository extends ChangeNotifier{

  BannerRepository(){
    getBanner1();
    getBanner2();
  }

  List<BannerModel> _banners1 = [];
  
  List<BannerModel> get banners1 => _banners1;
  
  set banners1(value){
    _banners1 = value;
    notifyListeners();
  }

  int _activeIndex1 = 0;

  int get activeIndex1 => _activeIndex1;

  set activeIndex1(int index) {
    _activeIndex1 = index;
    notifyListeners();
  }

  List<BannerModel> _banners2 = [];

  List<BannerModel> get banners2 => _banners2;

  set banners2(value){
    _banners2 = value;
    notifyListeners();
  }


  Future<void> getBanner1() async {
    _banners1 = [];

    var ref = FirebaseDatabase.instance.ref().child("banners").child("slider1");
    // Listen for changes in the database
    ref.onValue.listen((event) {
      // Check if data exists
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
        _banners1.clear(); // Clear existing data
        data.forEach((key, value) {
          _banners1.add(BannerModel(image: value['image'], link: value['link']));
        });
        notifyListeners();
      }
    });
  }

  Future<void> getBanner2() async {
    _banners2 = [];

    var ref = FirebaseDatabase.instance.ref().child("banners").child("slider2");

    // Listen for changes in the database
    ref.onValue.listen((event) {
      // Check if data exists
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
        _banners2.clear(); // Clear existing data
        data.forEach((key, value) {
          _banners2.add(BannerModel(image: value['image'], link: value['link']));
        });
        notifyListeners();
      }
    });
  }

  Future getBanners() async{
    await getBanner1();
    await getBanner2();
  }
}