import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/onboarding_screen.dart';
import 'package:bukizz/utils/helper/providers.dart';
import 'package:bukizz/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'Notifications/notifications.dart';
import 'data/models/user_details.dart';
import 'constants/strings.dart';
import 'constants/theme.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Load user data from SharedPreferences and set it to AppConstants
  MainUserDetails? savedUser =
      await MainUserDetails.loadFromSharedPreferences();
  if (savedUser != null) {
    AppConstants.userData = savedUser;
    AppConstants.isLogin = true;
    print("User data loaded: ${savedUser.name}, ${savedUser.email}");
  } else {
    print("No saved user data found");
  }

  // Run the app only once
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MultiProvider(
        providers: providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightThemeData,
          title: AppString.appName,
          initialRoute: OnboardingScreen.route,
          onGenerateRoute: RouteGenerator.generateRoute,
          // Add error handling for navigation crashes
          builder: (context, child) {
            // Error boundary to catch navigation issues
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return Material(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.red),
                        SizedBox(height: 16),
                        Text(
                          'Something went wrong!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Please restart the app',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            };
            return child ?? Container();
          },
          // Add navigation observers for debugging
          navigatorObservers: [
            _NavigationObserver(),
          ],
        ),
      );
    });
  }
}

// Custom navigation observer to track and debug navigation issues
class _NavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    print('Navigation: Pushed ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    print('Navigation: Popped ${route.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    print('Navigation: Removed ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    print(
        'Navigation: Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
  }
}
