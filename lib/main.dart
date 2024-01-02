// main.dart

import 'package:bukizz_frontend/screens/Signin_Screen.dart';
import 'package:bukizz_frontend/screens/Signup_Screen.dart';
import 'package:bukizz_frontend/screens/Tab_Screen.dart';
import 'package:bukizz_frontend/screens/ecommerce_screens/cart_screen.dart';
import 'package:flutter/material.dart';



// Import the new screen

void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // Use BottomNavigationScreen as the home screen
      home:Cart(),
    );
  }
}
