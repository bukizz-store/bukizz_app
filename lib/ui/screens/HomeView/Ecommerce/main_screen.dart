import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/ecommerce_home.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/onboarding%20screen/location.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/onboarding%20screen/onboarding_screen.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/profile/profile_screen.dart';
import 'package:bukizz_1/ui/screens/HomeView/homeScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/providers/bottom_nav_bar_provider.dart';
import 'Cart/cart_screen.dart';
import 'Cart/empty_cart_screen.dart';
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

  initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentScreen(context),
      bottomNavigationBar: Consumer<BottomNavigationBarProvider>(
        builder: (context, provider, child) {
          return CurvedNavigationBar(
            backgroundColor: Color(0xFF39A7FF),
            items: const [
              Icon(Icons.home),
              Icon(Icons.shopping_cart),
              Icon(Icons.notifications),
              Icon(Icons.category),
              Icon(Icons.person),
            ],
            index: provider.selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              provider.selectedIndex = index;
            },
          );
        },
      ),
    );
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
