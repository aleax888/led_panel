import 'package:flutter/material.dart';

enum CrawlTextDirectionEnum {
  toBottom(
    label: 'To Bottom',
    icon: Icons.arrow_downward_rounded,
    multiplier: 1,
    alignment: Alignment.bottomCenter,
  ),
  toTop(
    label: 'To Top',
    icon: Icons.arrow_upward_rounded,
    multiplier: -1,
    alignment: Alignment.topCenter,
  );

  const CrawlTextDirectionEnum({
    required this.label,
    required this.icon,
    required this.multiplier,
    required this.alignment,
  });

  final String label;
  final IconData icon;
  final double multiplier;
  final Alignment alignment;
}
