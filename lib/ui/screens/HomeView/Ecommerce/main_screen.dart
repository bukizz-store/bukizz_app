import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/data/providers/stationary_provider.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/profile_screen.dart';
import 'package:bukizz/ui/screens/HomeView/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarProvider>(builder: (context , bottomProvider , child){
      return Scaffold(
        body: _buildCurrentScreen(),
        bottomNavigationBar: BottomNavigationBar(
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
              unselectedItemColor: AppColors.schoolTextColor,
              unselectedFontSize: 8,
              selectedFontSize: 10,
              selectedItemColor: AppColors.productButtonSelectedBorder,
              currentIndex: bottomProvider.selectedIndex,
              showUnselectedLabels: true,
              onTap: bottomProvider.setSelectedIndex, // Add this line
            )
      );
    },);
  }


  Widget _buildCurrentScreen() {
    switch (context.watch<BottomNavigationBarProvider>().selectedIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return const Cart();
      case 2:
        return const NotificationScreen();
      case 3:
        return const CategoryScreen();
      case 4:
        return const ProfileScreen();
      default:
        return Container();
    }
  }
}

