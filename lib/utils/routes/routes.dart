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
import 'package:bukizz/ui/screens/HomeView/homeScreen.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/otp_screen.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import '../../ui/screens/HomeView/Ecommerce/Cart/cart_screen.dart';
import '../../ui/screens/HomeView/Ecommerce/product/view_all_schools.dart';
import '../../ui/screens/HomeView/Ecommerce/profile/address_screen.dart';
import '../../ui/screens/Signup and SignIn/Signin_Screen.dart';
import '../../ui/screens/Signup and SignIn/Signup_Screen.dart';
import '../../ui/screens/Signup and SignIn/reset_password.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignIn.route:
        return MaterialPageRoute(
          builder: (_) => const SignIn(),
        );

      case SignUp.route:
        return MaterialPageRoute(
          builder: (_) => const SignUp(),
        );

      case OTPVerificationScreen.route:
        final args = settings.arguments as Map<String, String>?;
        return MaterialPageRoute(
          builder: (_) => OTPVerificationScreen(
            email: args?['email'] ?? '',
            name: args?['name'] ?? '',
            password: args?['password'] ?? '',
          ),
        );

      case HomeScreen.route:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case Cart.route:
        return MaterialPageRoute(
          builder: (_) => Cart(),
        );
      case TabScreen.route:
        return MaterialPageRoute(builder: (_) => TabScreen());

      case ProductDescriptionScreen.route:
        return MaterialPageRoute(
          builder: (_) => ProductDescriptionScreen(),
        );

      case ViewAll.route:
        return MaterialPageRoute(
          builder: (_) => ViewAll(),
        );

      case Checkout1.route:
        return MaterialPageRoute(
          builder: (_) => Checkout1(),
        );
      case OtpScreen.route:
        return MaterialPageRoute(
          builder: (_) => OtpScreen(),
        );

      case MainScreen.route:
        return MaterialPageRoute(
          builder: (_) => MainScreen(),
        );
      case OnboardingScreen.route:
        return MaterialPageRoute(
          builder: (_) => OnboardingScreen(),
        );
      case SelectLocation.route:
        return MaterialPageRoute(
          builder: (_) => SelectLocation(),
        );
      case LocationScreen.route:
        return MaterialPageRoute(
          builder: (_) => const LocationScreen(),
        );
      case OrderScreen.route:
        return MaterialPageRoute(
          builder: (_) => const OrderScreen(),
        );
      case OrderDetailsScreen.route:
        return MaterialPageRoute(
          builder: (_) => const OrderDetailsScreen(),
        );
      case KnowMoreScreen.route:
        return MaterialPageRoute(
          builder: (_) => const KnowMoreScreen(),
        );
      case RatingsScreen.route:
        return MaterialPageRoute(
          builder: (_) => const RatingsScreen(),
        );

      case AddAddress.route:
        return MaterialPageRoute(
          builder: (_) => const AddAddress(),
        );

      case ReviewScreen.route:
        return MaterialPageRoute(
          builder: (_) => const ReviewScreen(),
        );
      case ContactUsScreen.route:
        return MaterialPageRoute(
          builder: (_) => ContactUsScreen(),
        );
      case ViewAllStationaryScreen.route:
        return MaterialPageRoute(
          builder: (_) => ViewAllStationaryScreen(),
        );

      case GeneralProductScreen.route:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => GeneralProductScreen(
            product: args?['product'] ?? 'Products',
          ),
        );

      case GeneralProductDescriptionScreen.route:
        return MaterialPageRoute(
          builder: (_) => const GeneralProductDescriptionScreen(),
        );

      case ForgotPasswordScreen.route:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordScreen(),
        );
      case UniformDescriptionScreen.route:
        return MaterialPageRoute(
          builder: (_) => UniformDescriptionScreen(),
        );
      case AddressScreen1.route:
        return MaterialPageRoute(
          builder: (_) => AddressScreen1(),
        );
      case PrivacyPolicy.route:
        return MaterialPageRoute(
          builder: (_) => PrivacyPolicy(),
        );
      case AllPoliciesScreen.route:
        return MaterialPageRoute(
          builder: (_) => AllPoliciesScreen(),
        );
      case TermsOfUse.route:
        return MaterialPageRoute(
          builder: (_) => TermsOfUse(),
        );

      case ReturnPolicyPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const ReturnPolicyPage(),
        );
      default:
        return _errorRoute();
    }
  }

  // handling the error
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Error: Invalid route'),
        ),
      ),
    );
  }
}
