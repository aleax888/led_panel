import 'package:flutter/material.dart';

/// Direction in which the content of a [LedPanel] moves.
enum MarqueeDirectionEnum {
  toLeft(
    icon: Icons.arrow_back_rounded,
    label: 'Left',
    multiplier: -1,
    alignment: Alignment(-1, 0),
  ),
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

  final IconData icon;
  final String label;
  final double multiplier;
  final Alignment alignment;
}
