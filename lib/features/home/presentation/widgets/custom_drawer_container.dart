import 'package:flutter/material.dart';
import '../../../../core/presentation/styles/font_styles.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/presentation/widgets/custom_text.dart';

class CustomDrawerContainer extends HookConsumerWidget {
  const CustomDrawerContainer(  {required this.label, required this.child,super.key});
  final String label;
  final Widget child;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText.f12(context, label,weight: FontStyles.fontWeightBlack),
        child],
    );
  }
}
