import 'package:flutter/material.dart';

/// Enum representing the direction in which text can scroll in a marquee animation.
enum MarqueeDirectionEnum {
  /// Text scrolls from the left to the right
  toLeft(
    icon: Icons.arrow_back_rounded,
    label: 'Left',
    multiplier: -1,
    alignment: Alignment(-1, 0),
  ),

  /// Text scrolls from the right to the left
  toRight(
    icon: Icons.arrow_forward_rounded,
    label: 'Right',
    multiplier: 1,
    alignment: Alignment(1, 0),
  );

  const MarqueeDirectionEnum({
    required this.icon,
    required this.label,
    required this.multiplier,
    required this.alignment,
  });

  /// The icon representing the marquee direction type, used in the UI.
  final IconData icon;
  /// The human-readable label for the marquee direction type.
  final String label;
  /// The multiplier used to determine the direction of the marquee.
  final double multiplier;
  /// The alignment used to position the text based on the marquee direction.
  final Alignment alignment;
}
