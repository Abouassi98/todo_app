import 'package:flutter/material.dart';
import 'core/core_features/theme/presentation/utils/themes/i_theme.dart';
import 'core/core_features/theme/presentation/utils/themes/theme_light.dart';
import 'core/presentation/routing/app_router.dart';
import 'core/presentation/routing/navigation_service.dart';
import 'core/presentation/utils/riverpod_framework.dart';
import 'core/presentation/widgets/platform_widgets/platform_app.dart';


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return Theme(
      data: ThemeLight().getThemeData(),
      child: PlatformApp(
        routerConfig: router,
        builder: (_, child) {
          return GestureDetector(
            onTap: NavigationService.removeFocus,
            child: child,
          );
        },
        title: 'ToDo App',
        color: Theme.of(context).colorScheme.primary,
        locale: const Locale('en', 'EN'),

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
