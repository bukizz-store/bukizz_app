import 'package:bukizz/constants/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../../models/ecommerce/notifications/notification_model.dart';

class NotificationRepository extends ChangeNotifier {
  bool _isNotificationLoaded = false;

  bool get isNotificationLoaded => _isNotificationLoaded;

  void setIsNotificationLoaded(bool value) {
    _isNotificationLoaded = value;
    notifyListeners();
  }

  List<NotificationModel> notifications = [];

  //push random notification data to firebase database

  static void pushNotificationData() {
    NotificationModel notificationModel = NotificationModel(
      navInit: 'Your Order is',
      navLast: 'Delivered',
      content: 'Your product English Book Set - Wisdom World School - Class 1st is delivered',
      image: 'https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL10.png?alt=media&token=b94b7399-ece5-4382-9f7c-3c5023ed944d',
      date: DateTime.now().toIso8601String(), notificationId: '1', link: '/order/7b649a50-3137-1ee2-930a-1720df08a8b6',
    );
    var ref = FirebaseDatabase.instance.ref().child('notifications').child(AppConstants.userData.uid);
    ref.push().set(notificationModel.toMap()).then((value) => print('Notification Data Pushed'));
  }
}