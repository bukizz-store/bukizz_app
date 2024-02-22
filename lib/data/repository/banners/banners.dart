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
    var data = FirebaseDatabase.instance.ref().child("banners").child("slider1");
    print(data.parent.)
  }
}