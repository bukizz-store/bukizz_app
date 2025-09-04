import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService {
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
  static bool _isInitialized = false;

  /// Initialize Crashlytics service
  static Future<void> initialize() async {
    if (_isInitialized) return;
    
    // Enable Crashlytics collection for both debug and release mode for testing
    await _crashlytics.setCrashlyticsCollectionEnabled(true);
    
    // Check if Crashlytics is enabled
    bool isEnabled = await _crashlytics.isCrashlyticsCollectionEnabled;
    if (kDebugMode) {
      print('🔥 Crashlytics collection enabled: $isEnabled');
      print('🔥 Debug mode: $kDebugMode');
    }
    
    // Send a test log to verify connection (non-blocking)
    _crashlytics.log('🔥 Crashlytics initialized successfully');
    
    _isInitialized = true;
  }

  /// Set user information for crash reports (non-blocking)
  static void setUserInfo({
    required String userId,
    String? email,
    String? name,
  }) {
    if (kDebugMode) {
      print('🔥 Setting user info - ID: $userId, Email: $email, Name: $name');
    }
    
    // Make these operations non-blocking by not awaiting them
    _crashlytics.setUserIdentifier(userId);
    if (email != null) {
      _crashlytics.setCustomKey('user_email', email);
    }
    if (name != null) {
      _crashlytics.setCustomKey('user_name', name);
    }
  }

  /// Record a non-fatal error (non-blocking for better performance)
  static void recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
  }) {
    if (kDebugMode) {
      print('🔥 Recording error: $exception');
      print('🔥 Reason: $reason');
      print('🔥 Fatal: $fatal');
    }
    
    // Make this non-blocking to avoid UI delays
    _crashlytics.recordError(
      exception,
      stackTrace,
      reason: reason,
      fatal: fatal,
    );
  }

  /// Log a custom message (non-blocking)
  static void log(String message) {
    if (kDebugMode) {
      print('🔥 Crashlytics log: $message');
    }
    // Make this non-blocking to avoid delays
    _crashlytics.log(message);
  }

  /// Set custom key-value pairs (non-blocking)
  static void setCustomKey(String key, dynamic value) {
    if (kDebugMode) {
      print('🔥 Setting custom key: $key = $value');
    }
    // Make this non-blocking to avoid delays
    _crashlytics.setCustomKey(key, value);
  }

  /// Record Flutter-specific errors (non-blocking)
  static void recordFlutterError(FlutterErrorDetails errorDetails) {
    if (kDebugMode) {
      print('🔥 Recording Flutter error: ${errorDetails.exception}');
    }
    _crashlytics.recordFlutterFatalError(errorDetails);
  }

  /// Force a crash for testing (use only for testing!)
  static void testCrash() {
    if (kDebugMode) {
      print('🔥 TRIGGERING TEST CRASH - APP WILL CRASH NOW!');
    }
    _crashlytics.crash();
  }

  /// Check if crash reporting is enabled
  static Future<bool> isCrashlyticsCollectionEnabled() async {
    return await _crashlytics.isCrashlyticsCollectionEnabled;
  }

  /// Send a test crash report without crashing the app (async for testing only)
  static Future<void> sendTestCrashReport() async {
    if (kDebugMode) {
      print('🔥 Sending test crash report...');
    }
    try {
      throw Exception('🔥 TEST CRASH REPORT - This is a test exception to verify Crashlytics integration');
    } catch (error, stackTrace) {
      recordError(
        error,
        stackTrace,
        reason: 'Test crash report sent from debug mode',
        fatal: false,
      );
    }
  }
}