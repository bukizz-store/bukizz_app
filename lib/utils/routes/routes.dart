import 'package:bukizz_1/ui/screens/HomeView/homeScreen.dart';
import 'package:flutter/material.dart';
import '../../ui/screens/HomeView/Ecommerce/Cart/cart_screen.dart';
import '../../ui/screens/Signin_Screen.dart';
import '../../ui/screens/Signup_Screen.dart';

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


