import 'package:flutter/material.dart';

/// Animates a child by changing its opacity and scale.
class FadeScaleAnimator extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const FadeScaleAnimator({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  State<FadeScaleAnimator> createState() => FadeScaleAnimatorState();
}

class FadeScaleAnimatorState extends State<FadeScaleAnimator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    final curve = CurvedAnimation(parent: _controller, curve: widget.curve);

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(curve);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(scale: _scaleAnimation.value, child: child),
        );
      },
      child: widget.child,
    );
  }

  /// Fades and scales the child out.
  Future<void> playFadeOut() => _controller.forward();

  /// Reverses the animation and restores the child.
  Future<void> playFadeIn() => _controller.reverse();
}
