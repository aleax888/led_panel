import 'package:flutter/material.dart';

/// Displays a circular rainbow gradient for color selection.
class RainbowAngularGradient extends StatelessWidget {
  final double width;
  final double height;
  const RainbowAngularGradient({
    super.key,
    this.width = 100.0,
    this.height = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          startAngle: 0,
          endAngle: 2 * 3.14159,
          colors: const [
            Color(0xFFFF0000), // Red
            Color(0xFFFF8000), // Orange
            Color(0xFFFFFF00), // Yellow
            Color(0xFF80FF00), // Light green
            Color(0xFF00FF00), // Green
            Color(0xFF00FFFF), // Cyan
            Color(0xFF0080FF), // Light blue
            Color(0xFF0000FF), // Blue
            Color(0xFF8000FF), // Purple
            Color(0xFFFF00FF), // Magenta
            Color(0xFFFF0000), // Closes the gradient
          ],
        ),
      ),
    );
  }
}
