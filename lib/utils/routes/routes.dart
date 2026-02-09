import 'package:bukizz/ui/screens/HomeView/Ecommerce/checkout/add_address.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/checkout/checkout1.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/location.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/manual_location.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/onboarding_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/Stationary/general_product_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/Stationary/general_product_description_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/Uniform/uniform_description_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/product_description_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab%20views/form_view_2.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/tab%20views/tab_screen.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/view_all_stationary.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/add_rating.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/add_review.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/contact_us.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/policies/all_policies.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/policies/privacy_policy.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/policies/return_policy.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/policies/terms_of_use.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/queryContact/contact_for_query.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/orders/order.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/orders/order_details.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/saved_address_screen.dart';
import 'package:bukizz/ui/screens/HomeView/homeScreen.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/otp_screen.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/otp_verification_screen.dart';
import 'package:bukizz/ui/screens/crashlytics_test_screen.dart';
import 'package:flutter/material.dart';
import '../../ui/screens/HomeView/Ecommerce/Cart/cart_screen.dart';
import '../../ui/screens/HomeView/Ecommerce/product/view_all_schools.dart';
import '../../ui/screens/HomeView/Ecommerce/profile/profile.dart';
import '../../ui/screens/Signup and SignIn/Signin_Screen.dart';
import '../../ui/screens/Signup and SignIn/Signup_Screen.dart';
import '../../ui/screens/Signup and SignIn/reset_password.dart';

class RouteGenerator {
  /// Create optimized route with fast transitions
  static Route<dynamic> _createFastRoute(Widget screen,
      {bool instant = false}) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: instant
          ? Duration.zero
          : const Duration(milliseconds: 150), // Much faster than default 300ms
      reverseTransitionDuration:
          instant ? Duration.zero : const Duration(milliseconds: 100),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (instant) return child; // No animation for instant routes

        // Fast slide transition
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic, // Smooth and fast curve
          )),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // For login/auth screens, use instant navigation for better UX
    bool useInstantTransition = [
      SignIn.route,
      SignUp.route,
      MainScreen.route,
      OnboardingScreen.route,
    ].contains(settings.name);

    switch (settings.name) {
      case SignIn.route:
        return _createFastRoute(const SignIn(), instant: useInstantTransition);

      case SignUp.route:
        return _createFastRoute(const SignUp(), instant: useInstantTransition);

      case OTPVerificationScreen.route:
        final args = settings.arguments as Map<String, String>?;
        return _createFastRoute(OTPVerificationScreen(
          email: args?['email'] ?? '',
          name: args?['name'] ?? '',
          password: args?['password'] ?? '',
        ));

      case HomeScreen.route:
        return _createFastRoute(HomeScreen());

      case Cart.route:
        return _createFastRoute(Cart());

      case TabScreen.route:
        return _createFastRoute(TabScreen());

      case ProductDescriptionScreen.route:
        return _createFastRoute(ProductDescriptionScreen());

      case ViewAll.route:
        return _createFastRoute(ViewAll());

      case Checkout1.route:
        return _createFastRoute(MainScreen(initialIndex: 3));

      case OtpScreen.route:
        return _createFastRoute(OtpScreen());

      case MainScreen.route:
        return _createFastRoute(MainScreen(), instant: useInstantTransition);

      case OnboardingScreen.route:
        return _createFastRoute(OnboardingScreen(),
            instant: useInstantTransition);

      case SelectLocation.route:
        return _createFastRoute(SelectLocation());

      case LocationScreen.route:
        return _createFastRoute(const LocationScreen());

      case OrderScreen.route:
        return _createFastRoute(const OrderScreen());

      case OrderDetailsScreen.route:
        return _createFastRoute(const OrderDetailsScreen());

      case KnowMoreScreen.route:
        return _createFastRoute(const KnowMoreScreen());

      case RatingsScreen.route:
        return _createFastRoute(const RatingsScreen());

      case AddAddress.route:
        return _createFastRoute(const AddAddress());

      case ReviewScreen.route:
        return _createFastRoute(const ReviewScreen());

      case ContactUsScreen.route:
        return _createFastRoute(ContactUsScreen());

      case ViewAllStationaryScreen.route:
        return _createFastRoute(ViewAllStationaryScreen());

      case GeneralProductScreen.route:
        final args = settings.arguments as Map<String, dynamic>?;
        return _createFastRoute(GeneralProductScreen(
          product: args?['product'] ?? 'Products',
        ));

      case GeneralProductDescriptionScreen.route:
        return _createFastRoute(const GeneralProductDescriptionScreen());

      case ForgotPasswordScreen.route:
        return _createFastRoute(ForgotPasswordScreen());

      case UniformDescriptionScreen.route:
        return _createFastRoute(UniformDescriptionScreen());

      case ProfileScreen.route:
        return _createFastRoute(ProfileScreen());

      case SavedAddressScreen.route:
        return _createFastRoute(const SavedAddressScreen());

      case PrivacyPolicy.route:
        return _createFastRoute(PrivacyPolicy());

      case AllPoliciesScreen.route:
        return _createFastRoute(AllPoliciesScreen());

      case TermsOfUse.route:
        return _createFastRoute(TermsOfUse());

      case ReturnPolicyPage.routeName:
        return _createFastRoute(const ReturnPolicyPage());

      case CrashlyticsTestScreen.route:
        return _createFastRoute(const CrashlyticsTestScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return _createFastRoute(
      Scaffold(
        body: Center(
          child: Text('No route defined'),
        ),
      ),
      instant: true,
    );
  }
}
