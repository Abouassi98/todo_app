import 'package:flutter/material.dart';
import '../../core_features/theme/presentation/utils/colors/app_static_colors.dart';
import 'custom_text.dart';
import 'platform_widgets/platform_app_bar.dart';
import '../styles/sizes.dart';

class CustomAppBar extends PlatformAppBar {
  CustomAppBar(
    BuildContext context, {
    super.key,
    double? height = Sizes.appBarHeight56,
    // bool centerTitle = false,
    List<Widget>? trailingActions,
    double elevation = 0,
  }) : super(
          toolbarHeight: height,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          actions: [
            if (trailingActions != null) ...trailingActions,

            // if (hasBackButton)
            //   const SizedBox(
            //     width: Sizes.appBarButtonR32 * 2,
            //   ),
            // if (hasMenuButton)
            //   const SizedBox(
            //     width: Sizes.appBarButtonR32 * 2,
            //   ),
          ],
          title: CustomText.f20(
            context,
            'TODO',
            color: AppStaticColors.blue,
     
          ),
          shapeBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          materialData: MaterialAppBarData(
            centerTitle: true,
            elevation: elevation,
            leadingWidth: Sizes.appBarButtonR32 * 2,
            titleSpacing: Sizes.paddingH20,
          ),
          cupertinoData: const CupertinoNavigationBarData(
            transitionBetweenRoutes: false,
            
            border: Border(
              bottom: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        );
}
