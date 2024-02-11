import 'package:bukizz/data/providers/stationary_provider.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/profile_screen.dart';
import 'package:bukizz/ui/screens/HomeView/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../data/providers/school_repository.dart';
import 'Cart/cart_screen.dart';
import 'categories/CategoryScreen.dart';
import 'notification/notification_screen.dart';

class MainScreen extends StatefulWidget {
  static const String route = '/mainscreen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<SchoolDataProvider>(builder: (context , schoolData , child){
      schoolData.loadData(context);
      return Scaffold(
        body: _buildCurrentScreen(context),
        bottomNavigationBar: Consumer<BottomNavigationBarProvider>(
          builder: (context, provider, child) {
            return BottomNavigationBar(

              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              unselectedItemColor: Color(0xFFA6A6A6),
              selectedItemColor: Color(0xFF058FFF),
              currentIndex: _selectedIndex,
              onTap: _onItemTapped, // Add this line
            );
          },
        ),
      );
    },);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildCurrentScreen(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return Cart();
      case 2:
        return NotificationScreen();
      case 3:
        return CategoryScreen();
      case 4:
        return ProfileScreen();
      default:
        return Container();
    }
  }
}

