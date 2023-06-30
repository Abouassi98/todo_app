import 'package:flutter/material.dart';
import '../../../../auth/domain/use_cases/log_in_uc.dart';
import '../../../../core/presentation/styles/sizes.dart';
import '../../../../core/presentation/utils/event.dart';
import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/presentation/widgets/custom_button.dart';
import '../../providers/sign_in_provider.dart';
import '../login_text_fields_section.dart';

class LoginFormComponent extends HookConsumerWidget {
  const LoginFormComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginFormKey = useMemoized(GlobalKey<FormState>.new);
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');

    void signIn() {
      final canSubmit = !ref.read(signInStateProvider).isLoading;

      if (canSubmit && loginFormKey.currentState!.validate()) {
        final params = SignInParams(
          email: emailController.text,
          password: passwordController.text,
        );
        ref
            .read(signInEventProvider.notifier)
            .update((_) => Some(Event.unique(params)));
      }
    }

    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.marginH28),
            child: LoginTextFieldsSection(
              emailController: emailController,
              passwordController: passwordController,
              onFieldSubmitted:
                  ref.isLoading(signInStateProvider) ? null : (_) => signIn(),
            ),
          ),
          const SizedBox(
            height: Sizes.marginV28,
          ),
          CustomButton(
            text: 'Sign In',
            onPressed: ref.isLoading(signInStateProvider) ? null : signIn,
          ),
          const SizedBox(
            height: Sizes.marginV28,
          ),
        ],
      ),
    );
  }
}
