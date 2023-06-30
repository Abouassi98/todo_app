import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

import '../../../core_features/theme/presentation/utils/colors/app_static_colors.dart';
import '../../utils/riverpod_framework.dart';
import 'flutter_local_notifications_provider.dart';

part 'show_local_notification_provider.g.dart';

@riverpod
Future<void> showLocalNotification(
  ShowLocalNotificationRef ref,
  ShowLocalNotificationParams params,
) async {
  final notificationService = ref.watch(flutterLocalNotificationsProvider);

  return notificationService.show(
    0,
    params.title,
    params.body,
    localNotificationDetails,
  );
}

@riverpod
Future<void> scheduleReminderotification(
  ScheduleReminderotificationRef ref,
  ShowLocalNotificationParams params,
) async {
  final notificationService = ref.watch(flutterLocalNotificationsProvider);
  return notificationService.zonedSchedule(
    0,
    params.title,
    params.body,
    params.zonedTime!,
    localNotificationDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

class ShowLocalNotificationParams {
  const ShowLocalNotificationParams({
    this.title,
    this.body,
    this.zonedTime,
  });
  final String? title, body;
  final TZDateTime? zonedTime;
}

const localNotificationDetails = NotificationDetails(
  android: AndroidNotificationDetails(
    'local_push_notification',
    'TODO App Notifications',
    channelDescription: 'This channel is used for important notifications.',
    importance: Importance.max,
    priority: Priority.high,
    color: AppStaticColors.primaryColor,
    enableLights: true,
  ),
  iOS: DarwinNotificationDetails(
    presentAlert: true,
    presentSound: true,
    presentBadge: true,
  ),
);
