import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core_features/theme/presentation/utils/app_theme.dart';

AppTheme getSystemTheme([Brightness? platformBrightness]) {
  return AppTheme.light;
}

SystemUiOverlayStyle getFullScreenOverlayStyle(
  BuildContext context,
) {
  return SystemUiOverlayStyle.light.copyWith(
    //For Android
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
    systemNavigationBarIconBrightness: Brightness.light,
  );
}
