import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/onboarding%20screen/onboarding_screen.dart';
import 'package:bukizz_1/utils/helper/providers.dart';
import 'package:bukizz_1/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/models/user_details.dart';
import 'constants/strings.dart';
import 'constants/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MainUserDetails? savedUser =
      await MainUserDetails.loadFromSharedPreferences();
  // AppConstants.userData = savedUser!;

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeData,
        title: AppString.appName,
        initialRoute: OnboardingScreen.route,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
//
