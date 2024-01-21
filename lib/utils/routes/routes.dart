import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/checkout/checkout1.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/product/product_description_screen.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/product/tab_screen.dart';
import 'package:bukizz_1/ui/screens/HomeView/homeScreen.dart';
import 'package:bukizz_1/ui/screens/Signup%20and%20SignIn/otp_screen.dart';
import 'package:flutter/material.dart';
import '../../ui/screens/HomeView/Ecommerce/Cart/cart_screen.dart';
import '../../ui/screens/HomeView/Ecommerce/product/tab views/about_school.dart';
import '../../ui/screens/HomeView/Ecommerce/product/view_all_schools.dart';
import '../../ui/screens/Signup and SignIn/Signin_Screen.dart';
import '../../ui/screens/Signup and SignIn/Signup_Screen.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case SignIn.route:
        return MaterialPageRoute(
          builder: (_) => const SignIn(),
        );

      case SignUp.route:
        return MaterialPageRoute(
          builder: (_) => const SignUp(),
        );

      case HomeScreen.route:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case Cart.route:
        return MaterialPageRoute(
          builder: (_) => Cart(),
        );
      case ProductScreen.route:
        return MaterialPageRoute(
          builder: (_) => ProductScreen(),
        );

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


