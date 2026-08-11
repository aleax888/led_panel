import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const FadeAnimation({
    super.key,
    required this.child,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
