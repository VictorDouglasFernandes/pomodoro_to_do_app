import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const String channel_id = '1';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }

  void showNotification(int id, {String? title, String? message}) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title ?? 'pomodoro_to_do_app',
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          channel_id,
          'pomododo_to_do_app.channel',
          channelDescription: 'Only channel for the application',
        ),
      ),
    );
  }
}
