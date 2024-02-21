import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  List<NavBar>items=[
    NavBar(null, Icons.home),
    NavBar(null, Icons.shopping_cart),
    NavBar(null, Icons.notifications),
    NavBar(null, Icons.category),
    NavBar(null, Icons.person),
  ];

  int _selectedIndex=0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int value){
    _selectedIndex=value;
    notifyListeners();
  }

}

class NavBar{
  Widget ? widget;
  IconData? icon;
  NavBar(this.widget,this.icon);
}