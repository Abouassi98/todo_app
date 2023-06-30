import 'package:flutter/material.dart';
import '../styles/sizes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/loading_indicators.dart';

class DataErrorComponent extends StatelessWidget {
  const DataErrorComponent({
    required this.title,
    required this.description,
    required this.onPressed,
    super.key,
  });
  final String title;
  final String description;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SmallLoadingAnimation(),
        const SizedBox(
          height: Sizes.marginV32,
        ),
        CustomText.f20(
          context,
          title,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: Sizes.marginV12,
        ),
        CustomText.f14(
          context,
          description,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: Sizes.marginV32,
        ),
        CustomButton(
          text: 'retry',
          onPressed: onPressed,
          buttonColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
