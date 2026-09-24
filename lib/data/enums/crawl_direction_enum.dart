import 'package:flutter/material.dart';

enum CrawlTextDirectionEnum {
  toBottom(
    label: 'To Bottom',
    multiplier: 1,
    alignment: Alignment.bottomCenter,
  ),
  toTop(label: 'To Top', multiplier: -1, alignment: Alignment.topCenter);

  const CrawlTextDirectionEnum({
    required this.label,
    required this.multiplier,
    required this.alignment,
  });

  final String label;
  final double multiplier;
  final Alignment alignment;
}
