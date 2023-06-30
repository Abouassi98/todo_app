import 'dart:developer';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:logging/logging.dart';
import 'app.dart';
import 'core/presentation/providers/provider_observers.dart';
import 'core/presentation/utils/riverpod_framework.dart';
import 'gen/my_assets.dart';
part 'core/presentation/services/main_initializer.dart';

void main() async {
  await _mainInitializer();
  runApp(
    ProviderScope(
      observers: [ProviderLogger()],
      child: const MyApp(),
    ),
  );
}
