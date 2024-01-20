import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/data/providers/cart_provider.dart';
import 'package:bukizz_1/data/providers/header_switch.dart';
import 'package:bukizz_1/data/providers/product_provider.dart';
import 'package:bukizz_1/data/providers/school_repository.dart';
import 'package:bukizz_1/data/repository/cart_view_repository.dart';
import 'package:bukizz_1/data/repository/product_view_repository.dart';
import 'package:bukizz_1/data/repository/user_repository.dart';
import 'package:bukizz_1/ui/screens/HomeView/homeScreen.dart';
import 'package:bukizz_1/pages/main_login.1.dart';
import 'package:bukizz_1/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:bukizz_1/ui/screens/Signup%20and%20SignIn/otp_screen.dart';
import 'package:bukizz_1/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/firebase_auth.dart';
import 'data/models/user_details.dart';
import 'constants/strings.dart';
import 'constants/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MainUserDetails? savedUser = await MainUserDetails.loadFromSharedPreferences();
  AppConstants.userData = savedUser!;



  runApp(
    MyApp(savedUser: savedUser),
  );
}

class MyApp extends StatefulWidget {
  final savedUser;
  const MyApp({super.key , required this.savedUser});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HeaderSwitchProvider(),),
        ChangeNotifierProvider(create: (_) => SchoolDataProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserRepositoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductViewRepository()),
        ChangeNotifierProvider(create: (context) => CartViewRepository()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeData,
        title: AppString.appName,
        initialRoute: widget.savedUser.uid != '' ? HomeScreen.route: SignIn.route,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
//