import 'package:flutter/material.dart';
import '../../data/network/network_info.dart';
import '../routing/app_router.dart';
import '../styles/sizes.dart';
import '../utils/riverpod_framework.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/loading_indicators.dart';

class NoInternetErrorComponent extends StatelessWidget {
  const NoInternetErrorComponent({super.key});

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
          'no Internet Connection',
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: Sizes.marginV12,
        ),
        CustomText.f14(
          context,
          'please Check Your Device Network',
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: Sizes.marginV32,
        ),
        HookConsumer(
          builder: (context, ref, child) {
            final networkInfo = ref.watch(networkInfoProvider);
            final isLoading = useState<bool>(false);

            Future<void> retryOnPressed() async {
              if (isLoading.value) return;

              isLoading.value = true;
              await networkInfo.hasInternetConnection.then(
                (value) {
                  if (value) {
                    const SplashRoute().go(context);
                  }
                },
              );
              isLoading.value = false;
            }

            return CustomButton(
              text: 'retry',
              onPressed: retryOnPressed,
              buttonColor: Theme.of(context).colorScheme.primary,
            );
          },
        ),
      ],
    );
  }
}
