import 'package:flutter/material.dart';

import '../../../auth/presentation/components/login/login_content_component.dart';

class NonDismissibleBottomSheet extends StatelessWidget {
  const NonDismissibleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        surfaceTintColor: Colors.white,
        elevation: 20,
        child: LoginContentComponent(),
      ),
    );
  }
}
