import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/native_profile_screen.dart';
import 'package:bukizz/ui/screens/webview_page.dart';
import 'package:bukizz/ui/screens/HomeView/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../constants/images.dart';
import '../../../../data/providers/bottom_nav_bar_provider.dart';
import 'Cart/cart_screen.dart';
import 'categories/CategoryScreen.dart';

import 'notification/notification_screen.dart';

class MainScreen extends StatefulWidget {
  static const String route = '/mainscreen';
  final int? initialIndex;

  const MainScreen({Key? key, this.initialIndex}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}



class _MainScreenState extends State<MainScreen> {
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    if (widget.initialIndex != null) {
       WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<BottomNavigationBarProvider>().setSelectedIndex(widget.initialIndex!);
       });
    }
  }

  /// Appends `&city=<city>` (or `?city=<city>`) to any URL if a city is selected.
  String _appendCity(String url) {
    if (AppConstants.location.isEmpty) return url;
    final separator = url.contains('?') ? '&' : '?';
    return '$url${separator}city=${AppConstants.location.toLowerCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarProvider>(builder: (context , bottomProvider , child){
      return Scaffold(
        body: Column(
          children: [
            Expanded(child: _buildCurrentScreen()),
            Container(
              height: 1,
              color: Colors.grey[300],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
              items:<BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: context.watch<BottomNavigationBarProvider>().selectedIndex == 0 ? SvgPicture.asset(AppImage.homeIcon,color:  AppColors.productButtonSelectedBorder) : SvgPicture.asset(AppImage.home_simple,color: AppColors.schoolTextColor),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: context.watch<BottomNavigationBarProvider>().selectedIndex == 1 
                  ? SvgPicture.asset(AppImage.categoriesIcons, color: AppColors.productButtonSelectedBorder)
                  : SvgPicture.asset(AppImage.categories_simple, color: AppColors.schoolTextColor),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: context.watch<BottomNavigationBarProvider>().selectedIndex == 2 
                  ? SvgPicture.asset(AppImage.notificationIcon, color: AppColors.productButtonSelectedBorder)
                  : SvgPicture.asset(AppImage.notification_simple, color: AppColors.schoolTextColor),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: context.watch<BottomNavigationBarProvider>().selectedIndex == 3 
                  ? SvgPicture.asset(AppImage.cartIcon, color: AppColors.productButtonSelectedBorder)
                  : SvgPicture.asset(AppImage.cart_simple, color: AppColors.schoolTextColor),
                  label: 'Cart',
                ),
                
                BottomNavigationBarItem(
                  icon: context.watch<BottomNavigationBarProvider>().selectedIndex == 4 
                  ? SvgPicture.asset(AppImage.profileIcon, color: AppColors.productButtonSelectedBorder)
                  : SvgPicture.asset(AppImage.profile_simple, color: AppColors.schoolTextColor),
                  label: 'Account',
                ),

              ],
              // unselectedItemColor: AppColors.schoolTextColor,
              unselectedFontSize: 10,
              selectedFontSize: 12,
              selectedItemColor: AppColors.productButtonSelectedBorder,
              currentIndex: bottomProvider.selectedIndex,
              showUnselectedLabels: true,
              onTap: bottomProvider.setSelectedIndex,
              type: BottomNavigationBarType.fixed,
              elevation: 10,
            )
      );
    },);
  }


  Widget _buildCurrentScreen() {
    switch (context.watch<BottomNavigationBarProvider>().selectedIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return WebViewPage(key: const ValueKey('category'), url: _appendCity('https://bukizz.in/category'), shouldInterceptCheckout: true);
      case 2:
        return const NotificationScreen();
      case 3:
        return WebViewPage(key: const ValueKey('cart'), url: _appendCity('https://bukizz.in/cart'));
      case 4:
        return const NativeProfileScreen();
      default:
        return Container();
    }
  }
}

