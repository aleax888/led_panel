import 'package:flutter/material.dart';

class DotPattern extends StatelessWidget {
  const DotPattern({
    super.key,
    this.radius = 3,
    this.spacing = 1,
    this.color = const Color.fromARGB(30, 217, 217, 217),
  });

  final double radius;
  final double spacing;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DotPatternPainter(
        radius: radius,
        spacing: spacing,
        color: color,
      ),
      size: Size.infinite,
    );
  }
}

class DotPatternPainter extends CustomPainter {
  DotPatternPainter({
    required this.radius,
    required this.spacing,
    required this.color,
  });

  final double radius;
  final double spacing;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final step = radius * 2 + spacing;

    for (double y = radius; y < size.height; y += step) {
      for (double x = radius; x < size.width; x += step) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DotPatternPainter oldDelegate) {
    return radius != oldDelegate.radius ||
        spacing != oldDelegate.spacing ||
        color != oldDelegate.color;
  }
}
