import 'package:flutter/material.dart';
import '../../../../core/core_features/theme/presentation/utils/colors/app_static_colors.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';

class AppBarIcon extends HookConsumerWidget {
  const AppBarIcon({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.marginH16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // alignment: Alignment.center,
            height: Sizes.marginV5,
            width: Sizes.font14,
            decoration: BoxDecoration(
              gradient: AppStaticColors.appbarIngredientColor,
              borderRadius: BorderRadius.circular(Sizes.cardR12),
            ),
          ),
          const SizedBox(
            height: Sizes.marginV5,
          ),
          Container(
            //alignment: Alignment.center,
            height: Sizes.marginV5,
            width: Sizes.icon24,
            decoration: BoxDecoration(
              gradient: AppStaticColors.appbarIngredientColor,
              borderRadius: BorderRadius.circular(Sizes.cardR12),
            ),
          ),
        ],
      ),
    );
  }
}
