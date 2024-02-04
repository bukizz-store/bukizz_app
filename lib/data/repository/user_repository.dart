import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/models/user_details.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryProvider extends ChangeNotifier{
  late MainUserDetails userDetail;

  MainUserDetails get getUserDetails => userDetail;

  void setUserDetails(MainUserDetails userDetails){
    userDetail = userDetails;
    notifyListeners();
  }

  void setUserData(MainUserDetails userDetails) async{
    userDetail = AppConstants.userData;
    notifyListeners();
  }


}