import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/onboarding%20screen/onboarding_screen.dart';
import 'package:bukizz/utils/helper/providers.dart';
import 'package:bukizz/utils/routes/routes.dart';
import 'package:bukizz/utils/crashlytics_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart'; // Add for performance debugging
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Notifications/notifications.dart';
import 'data/models/user_details.dart';
import 'constants/strings.dart';
import 'constants/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Global navigator key for safe navigation from providers/dispose
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Performance optimizations
  if (kDebugMode) {
    // Enable performance overlay in debug mode to monitor frame rates
    // debugPaintSizeEnabled = true; // Uncomment to see widget bounds
  }

  // Set preferred orientations first (lightweight operation)
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Enable hardware acceleration and disable unnecessary rendering layers
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Initialize Supabase
  try {
    await Supabase.initialize(
      url: 'https://qgufxqbsgewczleennbu.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFndWZ4cWJzZ2V3Y3psZWVubmJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc1NzgwOTcsImV4cCI6MjA3MzE1NDA5N30.En_vogdXxSu-xYGxc0EiLGNxwaADDFt6YaHEa63kvAM',
    );
     if (kDebugMode) {
      print('Supabase initialized successfully');
    }
  } catch (e) {
     if (kDebugMode) {
      print('Supabase initialization error: $e');
    }
  }

  // Initialize Firebase with timeout to prevent hanging
  try {
    await Firebase.initializeApp().timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        if (kDebugMode) {
          print('Firebase initialization timed out');
        }
        throw Exception('Firebase initialization timed out');
      },
    );
    if (kDebugMode) {
      print('Firebase initialized successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Firebase initialization error: $e');
    }
  }

  // Load user auth state BEFORE running app (critical for login persistence)
  await _loadUserAuthState();

  // Run the app with auth state already loaded
  runApp(const MyApp());

  // Initialize other services in the background AFTER app starts
  _initializeBackgroundServices();
}

// Initialize heavy services asynchronously after app starts
void _initializeBackgroundServices() async {
  try {
    // Initialize Firebase Crashlytics
    await CrashlyticsService.initialize();

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    // Pass all uncaught asynchronous errors to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    // Initialize notifications (non-blocking)
    try {
      await FirebaseApi.instance.initNotifications();
      if (kDebugMode) {
        print('Notifications initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to initialize notifications: $e');
      }
    }

    // Load user data from SharedPreferences
    _loadUserDataAsync();

  } catch (e) {
    if (kDebugMode) {
      print('Error initializing background services: $e');
    }
  }
}

// Load user auth state SYNCHRONOUSLY before app starts
// This ensures AppConstants.isLogin is set correctly when OnboardingScreen checks it
Future<void> _loadUserAuthState() async {
  try {
    MainUserDetails? savedUser =
        await MainUserDetails.loadFromSharedPreferences();
    if (savedUser != null) {
      AppConstants.userData = savedUser;
      AppConstants.isLogin = true;
      if (kDebugMode) {
        print("Auth state loaded: User=${savedUser.name}, isLogin=true");
      }
    } else {
      AppConstants.isLogin = false;
      if (kDebugMode) {
        print("Auth state: No saved user, isLogin=false");
      }
    }
  } catch (e) {
    AppConstants.isLogin = false;
    if (kDebugMode) {
      print("Error loading auth state: $e");
    }
  }
}

// Load additional user data and set Crashlytics info (runs after app start)
void _loadUserDataAsync() async {
  // Skip if already loaded in _loadUserAuthState
  if (AppConstants.isLogin) {
    // Just set Crashlytics info for already-loaded user
    try {
      CrashlyticsService.setUserInfo(
        userId: AppConstants.userData.uid.isNotEmpty
            ? AppConstants.userData.uid
            : AppConstants.userData.email.isNotEmpty
                ? AppConstants.userData.email
                : 'unknown_user',
        email: AppConstants.userData.email,
        name: AppConstants.userData.name,
      );
      if (kDebugMode) {
        print("Crashlytics user info set for: ${AppConstants.userData.name}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error setting Crashlytics user info: $e");
      }
    }
    return;
  }
  
  // Fallback: try to load user data if not already loaded
  try {
    MainUserDetails? savedUser =
        await MainUserDetails.loadFromSharedPreferences();
    if (savedUser != null) {
      AppConstants.userData = savedUser;
      AppConstants.isLogin = true;

      CrashlyticsService.setUserInfo(
        userId: savedUser.uid.isNotEmpty
            ? savedUser.uid
            : savedUser.email.isNotEmpty
                ? savedUser.email
                : 'unknown_user',
        email: savedUser.email,
        name: savedUser.name,
      );

      if (kDebugMode) {
        print("User data loaded (fallback): ${savedUser.name}, ${savedUser.email}");
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
          navigatorKey: navigatorKey,
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
