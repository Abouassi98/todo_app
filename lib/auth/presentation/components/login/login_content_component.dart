import 'package:flutter/material.dart';

import '../../../../core/presentation/styles/sizes.dart';

import 'login_form_component.dart';

class LoginContentComponent extends StatelessWidget {
  const LoginContentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: Sizes.marginV40,
        ),
        LoginFormComponent(),
      ],
    );
  }
}
