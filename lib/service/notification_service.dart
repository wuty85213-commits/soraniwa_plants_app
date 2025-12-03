import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:device_info_plus/device_info_plus.dart';


import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;


class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await _plugin.initialize(settings);
  }

  static Future<void> _schedule({
    required int id,
    required String title,
    required String body,
    required Duration delay,
  }) async {
    debugPrint('schedule起動!');
    final scheduled = DateTime.now().add(delay);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduled, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'plant_channel',
          'Plant Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  static Future<void> scheduleWateringNotification({
    required String localeCode,
    required int slotIndex,
    required int delayMs, // ← ms単位で渡せるようにする
  }) async {

    final title = (localeCode == 'ja')
        ? "水やりの時間です"
        : "Time to water your plant";

    final body = (localeCode == 'ja')
        ? "植物が水を欲しがっています！💧"
        : "The plant is getting dry 💧";

    await _schedule(
        id: 1000 + slotIndex, // 水やり系は slotIndex を通知IDにする
        title: title,
        body: body,
        delay: Duration(milliseconds: delayMs),
    );
  }

  static Future<void> scheduleHarvestNotification({
    required String localeCode,
    required int slotIndex,
    required int delayMs,
  }) async {

    final title = (localeCode == 'ja')
        ? "収穫の準備ができました！"
        : "Ready to harvest!";

    final body = (localeCode == 'ja')
        ? "植物が収穫可能になりました🌿"
        : "The plant is ready to harvest 🌿";

    await _schedule(
      id: 2000 + slotIndex, // 文字列IDを safe な int に変換
      title: title,
      body: body,
      delay: Duration(milliseconds: delayMs),
    );
  }

  static Future<void> cancel(int id) async {
    await _plugin.cancel(id);
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}

Future<void> requestExactAlarmPermission() async {
  if (!Platform.isAndroid) return;

  final info = await DeviceInfoPlugin().androidInfo;

  // Android 13+ のみ必要
  if (info.version.sdkInt >= 33) {
    final intent = AndroidIntent(
      action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
    );
    await intent.launch();
  }
}