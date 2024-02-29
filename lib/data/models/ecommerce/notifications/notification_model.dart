import 'dart:convert';

class NotificationModel {
  String notificationId;
  String navInit;
  String navLast;
  String content;
  String date;
  String link;
  String image;

  NotificationModel({
    required this.notificationId,
    required this.navInit,
    required this.navLast,
    required this.content,
    required this.date,
    required this.link,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'navInit': navInit,
      'navLast': navLast,
      'content': content,
      'date': date,
      'link': link,
      'image': image,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      notificationId: map['notificationId'] ?? '',
      navInit: map['navInit'] ?? '',
      navLast: map['navLast'] ?? '',
      content: map['content'] ?? '',
      date: map['date'] ?? '',
      link: map['link'] ?? '',
      image: map['image'] ?? '',
    );
  }

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}