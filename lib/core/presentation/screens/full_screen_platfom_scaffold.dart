import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../helpers/theme_helper.dart';
import '../widgets/platform_widgets/platform_scaffold.dart';

class FullScreenPlatformScaffold extends ConsumerWidget {
  const FullScreenPlatformScaffold({
    required this.body,

    this.platformAppBar,
    this.hasEmptyAppbar = false,
    super.key,
  });

  final Widget body; 
  final dynamic platformAppBar;

  final bool hasEmptyAppbar;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlatformScaffold(

      hasEmptyAppbar: hasEmptyAppbar,
      platformAppBar: platformAppBar,
      body: AnnotatedRegion(
        value: getFullScreenOverlayStyle(
          context,
        ),
        child: body,
      ),
    );
  }
}
