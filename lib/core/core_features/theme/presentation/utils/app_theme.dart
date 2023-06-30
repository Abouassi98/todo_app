import 'package:flutter/material.dart';
import 'themes/i_theme.dart';
import 'themes/theme_light.dart';

enum AppTheme {
  light,
}

extension ThemeExtension on AppTheme {
  ThemeData getThemeData() {
    switch (this) {
      case AppTheme.light:
        final themeLight = ThemeLight();
        return themeLight.getThemeData();
    }
  }

  IconData getThemeIcon() {
    switch (this) {
      case AppTheme.light:
        return Icons.wb_sunny;
    }
  }
}
