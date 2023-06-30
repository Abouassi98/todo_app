import 'package:flutter/material.dart';
import '../../../../core/core_features/theme/presentation/utils/colors/app_static_colors.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/presentation/utils/validators.dart';
import '../../../../core/presentation/widgets/platform_widgets/custom_form_field.dart';
import 'custom_drawer_container.dart';

class DrawerToDoNameItem extends HookConsumerWidget {
  const DrawerToDoNameItem({required this.controller, super.key});
  final TextEditingController controller;
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    //padding: const EdgeInsets.symmetric(vertical: Sizes.marginV20),
    return CustomDrawerContainer(
      label: 'Name',
      child: Column(
        children: [
          CustomFormField(
            hintText: 'Make your submission to the "To-Do"',
            controller: controller,
            validator: ValueValidators.validateName(context),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          ),
          Container(
            height: 1,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppStaticColors.containerIngredientColor,
            ),
          )
        ],
      ),
    );
  }
}
