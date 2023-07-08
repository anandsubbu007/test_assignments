// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:thiran_task/firebase_options.dart';
import 'package:thiran_task/domain/di/app_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppFcmHandler {
  static AppFcmHandler? _instance;
  AppFcmHandler._();
  static AppFcmHandler get instance => _instance ??= AppFcmHandler._();

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;

  Future firebaseInit() async {
    try {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      final fcmToken = await FirebaseMessaging.instance.getToken();
      await AppPreferences.instance.setNotificationToken(fcmToken!);
      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
        await AppPreferences.instance.setNotificationToken(fcmToken);
      }).onError((err) {});
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      await messaging.requestPermission(
          alert: true, announcement: false, badge: true, sound: true);
      await setupFlutterNotifications();
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      await FirebaseMessaging.instance.getInitialMessage();
      onMessage.listen(showFlutterNotification);
    } catch (e) {
      print('FireError: $e');
    }
  }

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high);

  bool isFlutterLocalNotificationsInitialized = false;

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) return;
    channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    isFlutterLocalNotificationsInitialized = true;
  }

  void showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    Map<String, dynamic> data = message.data;
    if (notification != null && android != null) {
      if (data.isNotEmpty) {
        flutterLocalNotificationsPlugin.show(
          1,
          notification.title ?? '',
          notification.body ?? '',
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.max,
                visibility: NotificationVisibility.public,
                channelAction: AndroidNotificationChannelAction.update,
                enableVibration: true,
                color: Colors.blue,
                number: 3,
                icon: "@mipmap/ic_launcher",
                category: AndroidNotificationCategory.message,
                channelDescription: channel.description),
          ),
        );
      }
    }
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await AppFcmHandler.instance.setupFlutterNotifications();
  AppFcmHandler.instance.showFlutterNotification(message);
}
