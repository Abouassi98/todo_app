import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../auth/presentation/providers/check_auth_provider.dart';
import '../../data/local/local_storage_caller/shared_pref_local_storage_caller.dart';
import '../../data/local/sqflite_caller/sqflite_pref_local_storage_caller.dart';
import '../../data/network/network_info.dart';
import '../routing/app_router.dart';

import '../services/local_notfication_service/flutter_local_notifications_provider.dart';
import '../utils/riverpod_framework.dart';
part 'splash_providers.g.dart';

@riverpod
Future<void> splashServicesWarmup(SplashServicesWarmupRef ref) async {
  await ref.watch(sharedPrefsAsyncProvider.future);
  await ref.watch(sqflitePrefsAsyncProvider.future);
  await ref.watch(configureLocalTimeZoneProvider.future);
  final min =
      Future<void>.delayed(const Duration(seconds: 1)); //Min Time of splash

  final s3 = Future<void>(() async {
    if (!kIsWeb) {
      await ref.watch(setupFlutterLocalNotificationsProvider.future);
    }
  });
  final s4 = ref.watch(checkAuthProvider.future);
  await Future.wait([min, s3, s4]);
}

@riverpod
Future<String> splashTarget(SplashTargetRef ref) async {
  final hasConnection =
      await ref.watch(networkInfoProvider).hasInternetConnection;
  if (hasConnection) {
    return const SignInRoute().location;
  } else {
    return const NoInternetRoute().location;
  }
}
