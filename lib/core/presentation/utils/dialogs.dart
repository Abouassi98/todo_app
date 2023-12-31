import 'package:flutter/material.dart';
import '../../../gen/my_assets.dart';
import '../routing/navigation_service.dart';
import '../styles/font_styles.dart';
import '../styles/sizes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/custom_icon.dart';
import '../widgets/custom_text.dart';
import '../widgets/loading_indicators.dart';

abstract class Dialogs {
  static Future<T?> showLoadingDialog<T extends Object?>(
    BuildContext context,
  ) async {
    return CustomDialog.showDialog(
      context,
      barrierDismissible: false,
      contentPadding: const EdgeInsets.symmetric(
        vertical: Sizes.dialogPaddingV28,
        horizontal: Sizes.dialogPaddingH20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.dialogR20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SmallLoadingAnimation(
            width: Sizes.loadingIndicatorR90,
            height: Sizes.loadingIndicatorR90,
          ),
          const SizedBox(
            height: Sizes.marginV12,
          ),
          CustomText.f18(
            context,
            'loading',
            weight: FontStyles.fontWeightMedium,
          ),
        ],
      ),
    );
  }

  static Future<T?> showErrorDialog<T extends Object?>(
    BuildContext context, {
    required String message,
  }) async {
    return CustomDialog.showDialog(
      context,
      contentPadding: const EdgeInsets.symmetric(
        vertical: Sizes.dialogPaddingV28,
        horizontal: Sizes.dialogPaddingH20,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: Sizes.marginH28,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.dialogR20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomIcon.i72(
            MyAssets.ASSETS_IMAGES_CORE_DIALOG_WIDGET_ICONS_ERROR_PNG,
            color: const Color(0xffcca76a),
          ),
          const SizedBox(
            height: Sizes.marginV12,
          ),
          CustomText.f18(
            context,
            'ops error',
            textAlign: TextAlign.center,
            weight: FontStyles.fontWeightBold,
            //alignment: Alignment.center,
          ),
          const SizedBox(
            height: Sizes.marginV6,
          ),
          CustomText.f16(
            context,
            message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: Sizes.marginV20,
          ),
          CustomButton(
            text: 'oK',
            onPressed: () => NavigationService.popDialog(context),
          ),
        ],
      ),
    );
  }

  static Future<T?> showCustomDialog<T extends Object?>(
    BuildContext context, {
    required Widget child,
  }) async {
    return CustomDialog.showDialog<T>(
      context,
      contentPadding: const EdgeInsets.symmetric(
        vertical: Sizes.dialogPaddingV28,
        horizontal: Sizes.dialogPaddingH20,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: Sizes.marginH28,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.dialogR20),
      ),
      child: child,
    );
  }
}
