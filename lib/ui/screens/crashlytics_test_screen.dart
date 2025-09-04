import 'package:bukizz/utils/crashlytics_service.dart';
import 'package:flutter/material.dart';

class CrashlyticsTestScreen extends StatelessWidget {
  static const String route = '/crashlytics-test';

  const CrashlyticsTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crashlytics Test Screen'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Firebase Crashlytics Test',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            
            ElevatedButton(
              onPressed: () {
                CrashlyticsService.log('User clicked log message button');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Log message sent to Crashlytics')),
                );
              },
              child: Text('Send Log Message'),
            ),
            
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                CrashlyticsService.setCustomKey('test_button_pressed', DateTime.now().millisecondsSinceEpoch);
                CrashlyticsService.setCustomKey('screen_name', 'crashlytics_test');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Custom keys set in Crashlytics')),
                );
              },
              child: Text('Set Custom Keys'),
            ),
            
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                try {
                  // Simulate a non-fatal error
                  throw Exception('This is a test non-fatal error');
                } catch (error, stackTrace) {
                  CrashlyticsService.recordError(
                    error,
                    stackTrace,
                    reason: 'User triggered test error',
                    fatal: false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Non-fatal error recorded in Crashlytics')),
                  );
                }
              },
              child: Text('Record Non-Fatal Error'),
            ),
            
            SizedBox(height: 16),
            
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () {
                // This will cause a fatal crash for testing
                // Only use this for testing purposes
                CrashlyticsService.testCrash();
              },
              child: Text('Test Fatal Crash (Use Carefully!)'),
            ),
            
            SizedBox(height: 32),
            
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How to use Crashlytics in your app:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text('1. Wrap risky operations in try-catch blocks'),
                    Text('2. Use CrashlyticsService.recordError() for non-fatal errors'),
                    Text('3. Use CrashlyticsService.log() to add context'),
                    Text('4. Set custom keys to track user actions'),
                    Text('5. View reports in Firebase Console > Crashlytics'),
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