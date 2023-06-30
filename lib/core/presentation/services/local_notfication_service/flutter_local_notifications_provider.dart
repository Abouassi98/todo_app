import 'dart:convert';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import '../../../../features/notifications/data/models/app_notification.dart';
import '../../providers/provider_utils.dart';
import '../../utils/fp_framework.dart';
import '../../utils/riverpod_framework.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
part 'flutter_local_notifications_provider.g.dart';

@Riverpod(keepAlive: true)
FlutterLocalNotificationsPlugin flutterLocalNotifications(
  FlutterLocalNotificationsRef ref,
) {
  return ref.watch(setupFlutterLocalNotificationsProvider).requireValue;
}

@Riverpod(keepAlive: true)
Future<FlutterLocalNotificationsPlugin> setupFlutterLocalNotifications(
  SetupFlutterLocalNotificationsRef ref,
) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const androidSettings = AndroidInitializationSettings('ic_launcher_icon');
  const iosSettings = DarwinInitializationSettings(
    requestBadgePermission: false,
  );

  const settings =
      InitializationSettings(android: androidSettings, iOS: iosSettings);

  final sub =
      ref.listen(onSelectNotificationProvider.notifier, (prev, next) {});
  await flutterLocalNotificationsPlugin.initialize(
    settings,
    onDidReceiveBackgroundNotificationResponse:
        _localNotifiactionsBackgroundHandler,
    onDidReceiveNotificationResponse: (details) {
      if (details.payload != null) {
        final decodedPayload =
            jsonDecode(details.payload!) as Map<String, dynamic>;
        if (decodedPayload.isNotEmpty) {
          final ntf = AppNotification.fromJson(decodedPayload);
          sub.read().update((_) => Some(ntf));
        }
      }
    },
  );
  return flutterLocalNotificationsPlugin;
}

@Riverpod(keepAlive: true)
Future<void> configureLocalTimeZone(ConfigureLocalTimeZoneRef ref) async {
  tz.initializeTimeZones();
  final timeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZone));
}

@Riverpod(keepAlive: true)
class OnSelectNotification extends _$OnSelectNotification with NotifierUpdate {
  @override
  Option<AppNotification> build() => const None();
}

@pragma('vm:entry-point')
Future<void> _localNotifiactionsBackgroundHandler(
  NotificationResponse response,
) async {
  log('Handling a background message ${response.id} ');
}
