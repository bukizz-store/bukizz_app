import 'package:bukizz_1/auth/firebase_auth.dart';
import 'package:bukizz_1/auth/user_details.dart';
import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/pages/Home_Screen2.dart';
import 'package:bukizz_1/pages/main_login.1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  UserDetails? savedUser = await UserDetails.loadFromSharedPreferences();
  AppConstants.userData = savedUser!;

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          primaryColor: const Color(0xFF0A0E21),
          scaffoldBackgroundColor: const Color(0xFF0A0E21),
        ),
        home: savedUser != null ? HomeScreen() : SignInScreen(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A0E21),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
      ),
      // Use BottomNavigationScreen as the home screen
      home: ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: SignInScreen(),
      ),
    );
  }
}
