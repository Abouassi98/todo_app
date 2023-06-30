import 'package:flutter/material.dart';
import '../utils/riverpod_framework.dart';

class BottomToTopAnimationView extends StatefulHookWidget {
  const BottomToTopAnimationView({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  State<BottomToTopAnimationView> createState() =>
      _BottomToTopAnimationViewState();
}

class _BottomToTopAnimationViewState extends State<BottomToTopAnimationView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    useEffect(() {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => animationController.forward());
      return null;
    });

    return AnimatedBuilder(
      animation: animationController,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animationController,
          // FadeTransition and Transform : just for screen loading animation on fistTime
          child: Transform(
            transform: Matrix4.translationValues(
              0,
              40 * (1.0 - animationController.value),
              0,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
