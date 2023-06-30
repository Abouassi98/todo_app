import 'package:flutter/material.dart';
import '../../../../core/core_features/theme/presentation/utils/colors/app_static_colors.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/presentation/utils/validators.dart';
import '../../../../core/presentation/widgets/platform_widgets/custom_form_field.dart';
import 'custom_drawer_container.dart';

class DrawerToDoDetailItem extends HookConsumerWidget {
  const DrawerToDoDetailItem({required this.controller, super.key});
  final TextEditingController controller;
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    //padding: const EdgeInsets.symmetric(vertical: Sizes.marginV20),
    return CustomDrawerContainer(
      label: 'Description',
      child: Container(
        //alignment: Alignment.topLeft,
        margin: const EdgeInsets.only(top: Sizes.marginH12),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.cardR12)),
          border: Border.all(color: AppStaticColors.greyShadow),
        ),
        child: CustomFormField(
          controller: controller,
          hintText:
              'Lorem ipsum dolor sit amet, consectetur ex adipiscing elit, sed do eiusmod tempor incid idunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.', // controller: emailController,
          validator: ValueValidators.validateEmptyField(context),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          maxLines: 5,
        ),
      ),
    );
  }
}
