import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/onboarding_screen.dart';
import 'package:bukizz/utils/helper/providers.dart';
import 'package:bukizz/utils/routes/routes.dart';
import 'package:bukizz/utils/crashlytics_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart'; // Add for performance debugging
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

  // Performance optimizations
  if (kDebugMode) {
    // Enable performance overlay in debug mode to monitor frame rates
    // debugPaintSizeEnabled = true; // Uncomment to see widget bounds
  }

  // Enable hardware acceleration and disable unnecessary rendering layers
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  await Firebase.initializeApp();

  // Initialize Firebase Crashlytics (non-blocking for performance)
  await CrashlyticsService.initialize();
  
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Set preferred orientations (helps with performance)
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Load user data from SharedPreferences and set it to AppConstants (non-blocking)
  _loadUserDataAsync();

  // Run the app immediately (don't wait for user data loading)
  runApp(const MyApp());
}

// Load user data asynchronously to avoid blocking app startup
void _loadUserDataAsync() async {
  try {
    MainUserDetails? savedUser = await MainUserDetails.loadFromSharedPreferences();
    if (savedUser != null) {
      AppConstants.userData = savedUser;
      AppConstants.isLogin = true;
      
      // Set user info for Crashlytics (non-blocking)
      CrashlyticsService.setUserInfo(
        userId: savedUser.uid.isNotEmpty ? savedUser.uid : savedUser.email.isNotEmpty ? savedUser.email : 'unknown_user',
        email: savedUser.email,
        name: savedUser.name,
      );
      
      if (kDebugMode) {
        print("User data loaded: ${savedUser.name}, ${savedUser.email}");
      }
    } else {
      if (kDebugMode) {
        print("No saved user data found");
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error loading user data: $e");
    }
  }
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
