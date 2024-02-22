import 'dart:convert';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todolong/models/todo.dart';

class NotiTodo {
  int todoId;
  int notiId;
  NotiTodo(
    this.todoId,
    this.notiId,
  );
  factory NotiTodo.fromJson(Map<String, dynamic> json) {
    return NotiTodo(
      json['todoId'] as int,
      json['notiId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todoId': todoId,
      'notiId': notiId,
    };
  }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> _createNotificationChannel(
      String id, String name, String description) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidNotificationChannel = AndroidNotificationChannel(id, name,
        description: description, importance: Importance.max);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  Future<void> init() async {
    var status = await Permission.notification.status;

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    if (status.isDenied) {
      await Permission.notification.request();
    }
    if (status.isGranted) {
      await _createNotificationChannel(
          "channelID", "channelNAME", "channelDESC");
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('icon');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {});
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails("channelID", "channelNAME",
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            icon: "icon",
            playSound: true,
            enableVibration: true,
            sound: RawResourceAndroidNotificationSound('smile')),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    print("noti");
    return flutterLocalNotificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future selectNotification(dynamic payload) async {
    //Handle notification tapped logic here
    print(payload);
  }

  Future<void> addScheduledNotification(Todo todo) async {
    final dueDate = todo.dueDate!;
    if (todo.reminder != null) {
      final reminderTime = dueDate.add(todo.reminder!);
      // Trừ 10 phút từ thời gian reminder
      final scheduledTime = reminderTime.subtract(const Duration(minutes: 10));
      log(scheduledTime.toString());
      log(tz.TZDateTime.parse(tz.local, scheduledTime.toString()).toString());

      await flutterLocalNotificationsPlugin.zonedSchedule(
        todo.id!,
        todo.title,
        todo.description,
        tz.TZDateTime.parse(tz.local, scheduledTime.toString()),
        await notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }

    // notiList.add(NotiTodo(todo.id!, todo.id!));
    // _saveNotis();
  }

  Future<void> removeScheduledNotifications(int todoId) async {
    await flutterLocalNotificationsPlugin.cancel(todoId);
  }

  Future<void> adjustScheduleNotification(Todo todo) async {
    await flutterLocalNotificationsPlugin.cancel(todo.id!);
    final dueDate = todo.dueDate!;
    if (todo.reminder != null) {
      final reminderTime = dueDate.add(todo.reminder!);
      // Trừ 10 phút từ thời gian reminder
      final scheduledTime = reminderTime.subtract(const Duration(minutes: 10));
      log(scheduledTime.toString());
      log(tz.TZDateTime.parse(tz.local, scheduledTime.toString()).toString());
      await flutterLocalNotificationsPlugin.zonedSchedule(
        todo.id!, // ID của thông báo, có thể là ID của Todo
        todo.title, // Tiêu đề của thông báo
        todo.description, // Mô tả của thông báo
        tz.TZDateTime.parse(tz.local, scheduledTime.toString()),
        await notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
