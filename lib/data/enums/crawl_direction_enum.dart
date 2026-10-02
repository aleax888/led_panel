import 'package:flutter/material.dart';

/// Enum representing the direction in which text can crawl.
enum CrawlTextDirectionEnum {
  /// Text crawls from the top to the bottom
  toBottom(
    label: 'To Bottom',
    icon: Icons.arrow_downward_rounded,
    multiplier: 1,
    alignment: Alignment.bottomCenter,
  ),

  /// Text crawls from the bottom to the top
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

  /// The human-readable label for the crawl direction type.
  final String label;
  /// The icon representing the crawl direction type, used in the UI.
  final IconData icon;
  /// The multiplier used to determine the direction of the crawl.
  final double multiplier;
  /// The alignment used to position the text based on the crawl direction.
  final Alignment alignment;
}
