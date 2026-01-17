import 'package:bukizz/utils/crashlytics_service.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  /// Wrap async operations with error handling and Crashlytics reporting
  static Future<T?> handleAsync<T>(
    Future<T> Function() operation, {
    String? context,
    bool showSnackBar = false,
    BuildContext? buildContext,
  }) async {
    try {
      // Non-blocking log to avoid delays
      CrashlyticsService.log('Starting operation: ${context ?? "Unknown"}');
      final result = await operation();
      // Non-blocking log to avoid delays
      CrashlyticsService.log('Operation completed successfully: ${context ?? "Unknown"}');
      return result;
    } catch (error, stackTrace) {
      // Non-blocking error recording to avoid delays
      CrashlyticsService.recordError(
        error,
        stackTrace,
        reason: 'Error in ${context ?? "async operation"}',
        fatal: false,
      );
      
      if (showSnackBar && buildContext != null) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(
            content: Text('Something went wrong. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      
      print('Error in ${context ?? "operation"}: $error');
      return null;
    }
  }

  /// Handle synchronous operations
  static T? handleSync<T>(
    T Function() operation, {
    String? context,
    bool showSnackBar = false,
    BuildContext? buildContext,
  }) {
    try {
      // Non-blocking log to avoid delays
      CrashlyticsService.log('Executing sync operation: ${context ?? "Unknown"}');
      final result = operation();
      // Non-blocking log to avoid delays
      CrashlyticsService.log('Sync operation completed: ${context ?? "Unknown"}');
      return result;
    } catch (error, stackTrace) {
      // Non-blocking error recording to avoid delays
      CrashlyticsService.recordError(
        error,
        stackTrace,
        reason: 'Error in ${context ?? "sync operation"}',
        fatal: false,
      );
      
      if (showSnackBar && buildContext != null) {
        ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(
            content: Text('Something went wrong. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      
      print('Error in ${context ?? "operation"}: $error');
      return null;
    }
  }

  /// Log user actions for better crash context (non-blocking)
  static void logUserAction(String action, {Map<String, dynamic>? parameters}) {
    CrashlyticsService.log('User action: $action');
    if (parameters != null) {
      parameters.forEach((key, value) {
        CrashlyticsService.setCustomKey('user_action_$key', value);
      });
    }
  }

  /// Log navigation events (non-blocking)
  static void logNavigation(String from, String to) {
    CrashlyticsService.log('Navigation: $from -> $to');
    CrashlyticsService.setCustomKey('last_screen', to);
    CrashlyticsService.setCustomKey('previous_screen', from);
  }
}