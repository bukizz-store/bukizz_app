import 'package:flutter/material.dart';
import 'package:bukizz/Notifications/notifications.dart';

class NotificationTestScreen extends StatefulWidget {
  static const String route = '/notification-test';

  const NotificationTestScreen({Key? key}) : super(key: key);

  @override
  State<NotificationTestScreen> createState() => _NotificationTestScreenState();
}

class _NotificationTestScreenState extends State<NotificationTestScreen> {
  String _notificationStatus = 'Checking...';

  @override
  void initState() {
    super.initState();
    _checkNotificationStatus();
  }

  Future<void> _checkNotificationStatus() async {
    try {
      bool enabled = await FirebaseApi.instance.areNotificationsEnabled();
      setState(() {
        _notificationStatus = enabled ? 'Enabled ✅' : 'Disabled ❌';
      });
    } catch (e) {
      setState(() {
        _notificationStatus = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Test'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notification Status',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Permission: $_notificationStatus',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseApi.instance.showTestNotification();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Test notification sent!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error sending notification: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'Send Test Notification',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _checkNotificationStatus();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'Refresh Status',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instructions',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '1. Tap "Send Test Notification" to test local notifications\n'
                      '2. Check if notification appears in notification panel\n'
                      '3. If notifications don\'t work, check app settings\n'
                      '4. For Firebase notifications, send a test message from Firebase Console',
                      style: TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
