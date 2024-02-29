import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/data/providers/stationary_provider.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/profile_screen.dart';
import 'package:bukizz/ui/screens/HomeView/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constants/images.dart';
import '../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../data/providers/school_repository.dart';
import '../../../../data/repository/banners/banners.dart';
import '../../../../data/repository/category/category_repository.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarProvider>(builder: (context , bottomProvider , child){
      return Scaffold(
        body: _buildCurrentScreen(),
        bottomNavigationBar: BottomNavigationBar(
              items:<BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImage.homeIcon,color: context.watch<BottomNavigationBarProvider>().selectedIndex == 0 ? AppColors.productButtonSelectedBorder : AppColors.schoolTextColor,),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImage.cartIcon, color: context.watch<BottomNavigationBarProvider>().selectedIndex == 1 ? AppColors.productButtonSelectedBorder : AppColors.schoolTextColor,),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImage.notificationIcon,color: context.watch<BottomNavigationBarProvider>().selectedIndex == 2 ? AppColors.productButtonSelectedBorder : AppColors.schoolTextColor,),
                  label: 'Notification',

                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImage.categoriesIcons, color: context.watch<BottomNavigationBarProvider>().selectedIndex == 3 ? AppColors.productButtonSelectedBorder : AppColors.schoolTextColor,),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImage.profileIcon, color: context.watch<BottomNavigationBarProvider>().selectedIndex == 4 ? AppColors.productButtonSelectedBorder : AppColors.schoolTextColor),
                  label: 'Profile',
                ),

              ],
              unselectedItemColor: AppColors.schoolTextColor,
              unselectedFontSize: 10,
              selectedFontSize: 12,
              selectedItemColor: AppColors.productButtonSelectedBorder,
              currentIndex: bottomProvider.selectedIndex,
              showUnselectedLabels: true,
              onTap: bottomProvider.setSelectedIndex,
              type: BottomNavigationBarType.fixed,
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

