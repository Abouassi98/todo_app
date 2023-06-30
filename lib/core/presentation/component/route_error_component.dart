import 'package:flutter/material.dart';

import '../routing/app_router.dart';
import '../styles/font_styles.dart';
import '../styles/sizes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class RouteErrorComponent extends StatelessWidget {
  const RouteErrorComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomText.f20(
          context,
          'screen Not Found',
          textAlign: TextAlign.center,
          weight: FontStyles.fontWeightSemiBold,
        ),
        const SizedBox(
          height: Sizes.marginV28,
        ),
        CustomButton(
          text: 'go To Home',
          onPressed: () {
            const HomeShellRoute().go(context);
          },
          buttonColor: Theme.of(context).colorScheme.primary,
        )
      ],
    );
  }
}
