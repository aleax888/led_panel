import 'package:flutter/material.dart';

/// Botón de favorito reutilizable.
class FavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onChanged;
  final double pulseScale;
  final Duration duration;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onChanged,
    this.pulseScale = 2,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        weight: 50,
        tween: Tween(
          begin: 1.0,
          end: widget.pulseScale,
        ).chain(CurveTween(curve: Curves.easeOut)),
      ),
      TweenSequenceItem(
        weight: 50,
        tween: Tween(
          begin: widget.pulseScale,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: IconButton(
        tooltip: widget.isFavorite ? 'Quitar de favoritos' : 'Marcar favorito',
        onPressed: _handleTap,
        icon: Icon(
          widget.isFavorite
              ? Icons.star_rate_rounded
              : Icons.star_border_rounded,
        ),
      ),
    );
  }

  void _handleTap() {
    _controller.forward(from: 0).then((_) {
      if (mounted) widget.onChanged.call();
    });
  }
}
