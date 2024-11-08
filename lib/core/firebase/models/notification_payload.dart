import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationPayload {
  final String? title;
  final String? body;
  final Map<String, dynamic>? data;

  NotificationPayload({this.title, this.body, this.data});

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'data': data,
      };

  factory NotificationPayload.fromMessage(RemoteMessage message) {
    return NotificationPayload(
      title: message.notification?.title,
      body: message.notification?.body,
      data: message.data,
    );
  }
}
