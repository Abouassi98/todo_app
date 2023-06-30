import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../routing/app_router.dart';
import '../../widgets/responsive_widgets/widget_builders.dart';
import 'route_error_screen_compact.dart';

class RouteErrorScreen extends HookConsumerWidget {
  const RouteErrorScreen(this.error, {super.key});

  final Exception? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () {
        const SplashRoute().go(context);
        return Future.value(false);
      },
      child: WindowClassLayout(
        compact: (_) => OrientationLayout(
          portrait: (_) => const ErrorScreenCompact(),
        ),
      ),
    );
  }
}
