import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter101/core/config/routes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background message: ${message.notification!.body}");
}

class FCMNotification {
  static init() async {
    FirebaseMessaging.instance
        .getToken()
        .then((value) => print('FCM Token : ${value}'));

    // Foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message recieved");
      print('Foreground message ${message.notification!.body}');
    });

    // Background message
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    /// จัดการ FCM เมื่อกดที่ Notification บน Status bar
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }
}

class PushNotificationService {
  Future<void> init() async {
    RemoteMessage? initMes =
    await FirebaseMessaging.instance.getInitialMessage();

    _onNotificationClicked(initMes);

    FirebaseMessaging.instance.getToken().then((value) {
      if (kDebugMode) {
        print('FCM Token : ${value}');
      }
    });

    /// จัดการ FCM เมื่อกดที่ Notification บน Status bar
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _onNotificationClicked(initMes);
    });

    await enableIOSNotification();
    await registerNotificationListeners();
  }

  void _onNotificationClicked(RemoteMessage? initMes) {}

  enableIOSNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var androidSetting =
    const AndroidInitializationSettings("@mipmap/ic_launcher");

    var iOSSettings = const IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    RemoteMessage? recentMessage;

    // TODO : Do stuff with Foreground notification received (Foreground state)
    // onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      recentMessage = message;
      _showNotification(
          flutterLocalNotificationsPlugin, channel, recentMessage);
    });

    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // TODO : Do stuff with Background notification received (Terminated state)
      // App received a notification when it was killed
      // If initialMessage != null , construct our own
      // local notification to show to users using the created channel.
      _showNotification(
          flutterLocalNotificationsPlugin, channel, initialMessage);
    }

    var initSettings =
    InitializationSettings(android: androidSetting, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: (message) async {
        // TODO : Do stuff with Foreground notification click (Foreground state)
        // TODO : ข้อสังเกตจากการทดสอบเองคือใน iOS ไม่ว่าจะเป็นการทำงาน Background / Foreground จะไม่เข้าฟังก์ชันนี้แต่จะเข้า FirebaseMessaging.onMessageOpenedApp แทน | ใน Android ทำงานปกติ
        // This function handles the click in the notification when the app is in foreground
        if (recentMessage != null) {
          recentMessage!.data['type'] = "nearbyStore";
        }
        _onNotificationClickeds(recentMessage);
      },
    );
  }


  _onNotificationClickeds(RemoteMessage? message) {
    if (message != null) {
      switch (message.data['type']) {
        case 'nearbyStore':
          {
            Get.toNamed(Routes.nearbyStorePage);
          }
          break;
        case 'cart':
          {
            Get.toNamed(Routes.shoppingCartPage);
          }
          break;
      }
    }
  }

  androidNotificationChannel() =>
      const AndroidNotificationChannel(
          "high_impotance_channerl", "High Importance Notification",
          description: "this user test Noti", importance: Importance.max);

  void _showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      AndroidNotificationChannel channel,
      RemoteMessage? message,) {
    // Get.find<HomeController>().getNotificationsNumber();
    if (kDebugMode) {
      print(message);
    }
    RemoteNotification? notification = message!.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: android.smallIcon,
            playSound: true,
          ),
        ),
      );
    }
  }
}
