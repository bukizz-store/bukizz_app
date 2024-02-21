import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = AndroidInitializationSettings('mipmap/ic_launcher');
    // var iosInitialize = IOSInitializationSettings();
    var initializationSettings =
    InitializationSettings(android: androidInitialize,);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  static Future showBigTextNotifications({var id=0,required String title,required String body,var payload,required FlutterLocalNotificationsPlugin fln})async{
    AndroidNotificationDetails androidPlatformChannelSpecifies=new AndroidNotificationDetails(
        'you can name it whatever',
        'channel_name',
        playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var not=NotificationDetails(android: androidPlatformChannelSpecifies,);
    await fln.show(0,title,body,not);
  }
}
