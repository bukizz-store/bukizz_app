import 'package:flutter/foundation.dart';

class AuthView extends ChangeNotifier {
  bool _isAuth = true;

  bool get isAuth => _isAuth;

  void setAuth(bool value) {
    _isAuth = value;
    notifyListeners();
  }
}