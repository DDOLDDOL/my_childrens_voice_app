import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// {@template notification_repository}
/// Notification repository
/// {@endtemplate}
class NotificationRepository {
  /// {@macro notification_repository}
  NotificationRepository();

  final _plugin = FlutterLocalNotificationsPlugin();
  final _initializationSettings = const InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(),
  );
  final _notificationDetails = const NotificationDetails(
    android: AndroidNotificationDetails(
      'id',
      'name',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      autoCancel: false,
    ),
    iOS: DarwinNotificationDetails(),
  );

  /// initialize
  Future<void> init() async {
    await _plugin.initialize(_initializationSettings);
  }

  /// push message
  Future<void> push(
    int id,
    String title,
    String body, {
    String? payload,
  }) async {
    await _plugin.show(
      id,
      title,
      body,
      _notificationDetails,
      payload: payload,
    );
  }

  /// cancel all message
  void cancel() => _plugin.cancelAll();
}
