import 'package:flutter/foundation.dart';

class EmailAuth extends ChangeNotifier{
  bool _isEmailAuth = false;

  bool get isEmailAuth => _isEmailAuth;

  void setIsEmailAuth(bool value) {
    _isEmailAuth = value;
    notifyListeners();
  }


}