import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/core_features/theme/presentation/utils/themes/cupertino_custom_theme.dart';
import '../../../core/presentation/styles/sizes.dart';
import '../../../core/presentation/utils/validators.dart';
import '../../../core/presentation/widgets/platform_widgets/custom_text_form_field.dart';
import '../../../core/presentation/widgets/platform_widgets/platform_widget.dart';

class LoginTextFieldsSection extends ConsumerWidget {
  const LoginTextFieldsSection({
    required this.emailController,
    required this.passwordController,
    required this.onFieldSubmitted,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlatformWidget(
      material: (_) {
        return Column(
          children: _sharedItemComponent(
            context,
            ref,
            isMaterial: true,
          ),
        );
      },
      cupertino: (_) {
        return CupertinoFormSection.insetGrouped(
          decoration:
              CupertinoCustomTheme.cupertinoFormSectionDecoration(context),
          backgroundColor: Colors.transparent,
          margin: EdgeInsets.zero,
          children: _sharedItemComponent(
            context,
            ref,
            isMaterial: false,
          ),
        );
      },
    );
  }

  List<Widget> _sharedItemComponent(
    BuildContext context,
    WidgetRef ref, {
    required bool isMaterial,
  }) {
    return [
      CustomTextFormField(
        key: const ValueKey('login_email'),
        hintText: 'Enter your email',
        labelText: 'Email',
        controller: emailController,
        validator: ValueValidators.validateEmail(context),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
      ),
      if (isMaterial)
        const SizedBox(
          height: Sizes.textFieldMarginV20,
        ),
      CustomTextFormField(
        key: const ValueKey('login_password'),
        hintText: 'Enter your password',
        labelText: 'Password',
        controller: passwordController,
        validator: ValueValidators.validateLoginPassword(context),
        textInputAction: TextInputAction.go,
        obscureText: true,
        onFieldSubmitted: onFieldSubmitted,
      ),
    ];
  }
}
