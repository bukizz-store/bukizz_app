import 'package:bukizz/constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static FirebaseApi? _instance;
  static FirebaseApi get instance {
    _instance ??= FirebaseApi._();
    return _instance!;
  }

  FirebaseApi._();

  Future<void> initNotifications() async {
    try {
      // Request notification permissions (crucial for Android 13+)
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted notification permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional notification permission');
      } else {
        print('User declined or has not accepted notification permission');
        return;
      }

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Get FCM token
      final fcmToken = await _firebaseMessaging.getToken();
      if (fcmToken != null) {
        print('FCM Token: $fcmToken');
        AppConstants.fcmToken = fcmToken;
      }

      // Set up background message handler
      FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

      // Listen for foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Foreground Message Received');
        _displayNotification(message);
      });

      // Handle notification tap when app is in background/terminated
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print(
            'User tapped on notification when app was in background/terminated');
        _handleNotificationTapped(message);
      });

      // Handle notification tap when app is terminated
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        print('App opened from terminated state via notification');
        _handleNotificationTapped(initialMessage);
      }
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('Local notification tapped: ${response.payload}');
        // Handle local notification tap
        _handleLocalNotificationTap(response);
      },
    );

    // Create notification channel for Android
    await _createNotificationChannel();
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // Channel ID
      'High Importance Notifications', // Channel name
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Handle notifications when the app is in the background
  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    print('Handling background message:');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }

  // Display notification when app is in foreground
  void _displayNotification(RemoteMessage message) async {
    try {
      print('Displaying foreground notification:');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Payload: ${message.data}');

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        icon: '@mipmap/ic_launcher',
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await _flutterLocalNotificationsPlugin.show(
        message.hashCode, // Use message hash as unique ID
        message.notification?.title ?? 'New Notification',
        message.notification?.body ?? 'You have a new message',
        platformChannelSpecifics,
        payload: message.data.toString(),
      );
    } catch (e) {
      print('Error displaying notification: $e');
    }
  }

  // Handle Firebase notification tap
  void _handleNotificationTapped(RemoteMessage message) {
    print('Notification Tapped:');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');

    // Add your navigation logic here based on the message data
    _navigateBasedOnPayload(message.data);
  }

  // Handle local notification tap
  void _handleLocalNotificationTap(NotificationResponse response) {
    print('Local notification tapped with payload: ${response.payload}');

    if (response.payload != null) {
      // Parse the payload and navigate accordingly
      try {
        // You can parse the payload here and navigate to appropriate screen
        print('Processing notification payload: ${response.payload}');
      } catch (e) {
        print('Error processing notification payload: $e');
      }
    }
  }

  // Navigate based on notification payload
  void _navigateBasedOnPayload(Map<String, dynamic> data) {
    // Implement your navigation logic here
    // For example:
    // if (data.containsKey('screen')) {
    //   String screen = data['screen'];
    //   // Navigate to the appropriate screen
    // }
  }

  // Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    try {
      NotificationSettings settings =
          await _firebaseMessaging.getNotificationSettings();
      return settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
    } catch (e) {
      print('Error checking notification settings: $e');
      return false;
    }
  }

  // Show a local notification manually (for testing)
  Future<void> showTestNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      'Test Notification',
      'This is a test notification to verify functionality',
      platformChannelSpecifics,
      payload: 'test_notification',
    );
  }
}
