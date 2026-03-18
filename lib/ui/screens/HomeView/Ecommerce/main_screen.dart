import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/constants/constants.dart';
import 'package:flutter/services.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/native_profile_screen.dart';
import 'package:bukizz/ui/screens/webview_page.dart';
import 'package:bukizz/ui/screens/HomeView/homeScreen.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../constants/images.dart';
import '../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/buttons/Reusable_Button.dart';

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
  int _previousIndex = 0;
  bool _isShowingLoginPopup = false;

  @override
  void initState() {
    super.initState();
    final provider = context.read<BottomNavigationBarProvider>();
    _previousIndex = provider.selectedIndex;

    if (widget.initialIndex != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToIndex(widget.initialIndex!);
      });
    }

    // Listen for programmatic index changes (webview, product pages, snackbar, etc.)
    provider.addListener(_onProviderIndexChanged);
  }

  @override
  void dispose() {
    // Safe removal: only remove if still mounted and provider accessible
    try {
      context.read<BottomNavigationBarProvider>().removeListener(_onProviderIndexChanged);
    } catch (_) {}
    super.dispose();
  }

  /// Central gate – called both by the bottom nav tap AND by the provider listener.
  void _navigateToIndex(int index) {
    if (index == 3 && !AppConstants.isLogin) {
      // Revert to previous tab and show popup
      final provider = context.read<BottomNavigationBarProvider>();
      if (provider.selectedIndex == 3) {
        provider.setSelectedIndex(_previousIndex);
      }
      if (!_isShowingLoginPopup) {
        _showLoginRequiredPopup(context);
      }
      return;
    }
    _previousIndex = index;
    context.read<BottomNavigationBarProvider>().setSelectedIndex(index);
  }

  /// Fires when any code calls setSelectedIndex on the provider (e.g. webview, product pages)
  void _onProviderIndexChanged() {
    final current = context.read<BottomNavigationBarProvider>().selectedIndex;
    if (current == 3 && !AppConstants.isLogin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final provider = context.read<BottomNavigationBarProvider>();
        provider.setSelectedIndex(_previousIndex);
        if (!_isShowingLoginPopup) {
          _showLoginRequiredPopup(context);
        }
      });
    } else {
      _previousIndex = current;
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
              onTap: (index) => _navigateToIndex(index),
              type: BottomNavigationBarType.fixed,
              elevation: 10,
            )
      );
    },);
  }

  /// Shows a login-required popup when guest user taps on Cart
  void _showLoginRequiredPopup(BuildContext context) {
    _isShowingLoginPopup = true;
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Login Required',
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: _LoginRequiredDialog(
              onLogin: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, SignIn.route);
              },
              onCancel: () => Navigator.of(context).pop(),
            ),
          ),
        );
      },
    ).then((_) {
      _isShowingLoginPopup = false;
    });
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

/// Login-required dialog using the same components & design language as the rest
/// of the Bukizz app (ReusableElevatedButton, GoogleFonts.nunito, AppColors, etc.)
class _LoginRequiredDialog extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onCancel;

  const _LoginRequiredDialog({
    required this.onLogin,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final Dimensions dimensions = Dimensions(context);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: dimensions.width327,
          padding: EdgeInsets.symmetric(
            horizontal: dimensions.width24,
            vertical: dimensions.height24,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Cart icon ──
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.tertiaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppImage.cart_simple,
                    width: 28,
                    height: 28,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

              SizedBox(height: dimensions.height16),

              // ── Title ──
              Text(
                'Login to Continue',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),

              SizedBox(height: dimensions.height8),

              // ── Subtitle ──
              Text(
                'Sign in to view your cart and\ncomplete your purchase',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.schoolTextColor,
                  height: 1.45,
                ),
              ),

              SizedBox(height: dimensions.height24),

              // ── Primary CTA – same ReusableElevatedButton used everywhere ──
              ReusableElevatedButton(
                width: dimensions.width327,
                height: dimensions.height48,
                onPressed: onLogin,
                buttonText: 'Sign In',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),

              SizedBox(height: dimensions.height10),

              // ── Secondary – outlined "Not Now" ──
              GestureDetector(
                onTap: onCancel,
                child: Container(
                  width: dimensions.width327,
                  height: dimensions.height48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: AppColors.borderColor,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Not Now',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.schoolTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
