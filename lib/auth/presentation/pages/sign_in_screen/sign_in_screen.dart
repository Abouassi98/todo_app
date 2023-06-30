import 'package:flutter/material.dart';

import '../../../../core/core_features/theme/presentation/utils/colors/app_static_colors.dart';
import '../../../../core/presentation/screens/full_screen_platfom_scaffold.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/presentation/utils/scroll_behaviors.dart';
import '../../../../core/presentation/widgets/custom_text.dart';
import '../../../../core/presentation/widgets/custtom_bottom_sheet.dart';
import '../../providers/sign_in_provider.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.easyListen(signInStateProvider);
    return FullScreenPlatformScaffold(
      body: ScrollConfiguration(
        behavior: MainScrollBehavior(),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppStaticColors.loginBG,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.marginV62,
                        horizontal: Sizes.marginH28,
                      ).copyWith(bottom: Sizes.marginV50),
                      child: CustomText.f32(
                        context,
                        'Login',
                      ),
                    ),
                    const NonDismissibleBottomSheet(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
