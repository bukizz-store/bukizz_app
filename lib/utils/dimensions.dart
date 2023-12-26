import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DimensionsProvider with ChangeNotifier {
  late BuildContext _appContext;

  void init(BuildContext context) {
    _appContext = context;
    notifyListeners();
  }

  double get screenHeight => MediaQuery.of(_appContext).size.height;

  double get screenWidth => MediaQuery.of(_appContext).size.width;

  double get mainColpaddingleft => screenHeight / 15.625;
}
