import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

abstract interface class ScheduleNotificationService {
  Stream<String> get actions;
  Future<void> initialize();
  Future<bool> requestPermission();
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAtUtc,
    required String payload,
    required bool isTask,
  });
  Future<void> cancel(int id);
}

class LocalScheduleNotificationService implements ScheduleNotificationService {
  LocalScheduleNotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  final _actions = StreamController<String>.broadcast();
  bool _initialized = false;

  @override
  Stream<String> get actions => _actions.stream;

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    await _plugin.initialize(
      settings: InitializationSettings(
        android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          notificationCategories: [
            DarwinNotificationCategory(
              'keyspace_schedule_task',
              actions: [
                DarwinNotificationAction.plain('complete', 'Selesai'),
                DarwinNotificationAction.plain('snooze', 'Tunda 10 menit'),
                DarwinNotificationAction.plain('reschedule', 'Ubah waktu'),
              ],
            ),
            DarwinNotificationCategory(
              'keyspace_schedule_event',
              actions: [
                DarwinNotificationAction.plain('snooze', 'Tunda 10 menit'),
                DarwinNotificationAction.plain('reschedule', 'Ubah waktu'),
              ],
            ),
          ],
        ),
      ),
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null) {
          _actions.add('${response.actionId ?? 'open'}|$payload');
        }
      },
    );
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      tz_data.initializeTimeZones();
      final zone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(zone.identifier));
    }
    final launch = await _plugin.getNotificationAppLaunchDetails();
    final response = launch?.notificationResponse;
    if ((launch?.didNotificationLaunchApp ?? false) &&
        response?.payload != null) {
      scheduleMicrotask(
        () => _actions.add(
          '${response?.actionId ?? 'open'}|${response!.payload!}',
        ),
      );
    }
    _initialized = true;
  }

  @override
  Future<bool> requestPermission() async {
    await initialize();
    if (Platform.isAndroid) {
      return await _plugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
              ?.requestNotificationsPermission() ??
          false;
    }
    if (Platform.isIOS) {
      return await _plugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >()
              ?.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
    }
    return false;
  }

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAtUtc,
    required String payload,
    required bool isTask,
  }) async {
    await initialize();
    final local = tz.TZDateTime.from(scheduledAtUtc.toUtc(), tz.local);
    if (!local.isAfter(tz.TZDateTime.now(tz.local))) return;
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: local,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'keyspace_schedule_reminders',
          'Pengingat jadwal',
          channelDescription: 'Pengingat lokal event dan task KeySpace.',
          importance: Importance.high,
          priority: Priority.high,
          actions: [
            if (isTask) const AndroidNotificationAction('complete', 'Selesai'),
            const AndroidNotificationAction('snooze', 'Tunda 10 menit'),
            const AndroidNotificationAction('reschedule', 'Ubah waktu'),
          ],
        ),
        iOS: DarwinNotificationDetails(
          categoryIdentifier: isTask
              ? 'keyspace_schedule_task'
              : 'keyspace_schedule_event',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: payload,
    );
  }

  @override
  Future<void> cancel(int id) => _plugin.cancel(id: id);
}
