import 'package:flutter/material.dart';

import '../../component/no_internet_error_component.dart';
import '../../styles/sizes.dart';
import '../../utils/scroll_behaviors.dart';
import '../../widgets/platform_widgets/platform_scaffold.dart';

class NoInternetScreenCompact extends StatelessWidget {
  const NoInternetScreenCompact({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: ScrollConfiguration(
        behavior: MainScrollBehavior(),
        child: const CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Sizes.screenMarginV16,
                  horizontal: Sizes.screenMarginH28,
                ),
                child: NoInternetErrorComponent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
