import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/background_configs/solid_color_config_model.dart';

/// A widget that displays a solid color background for a LED panel, based on the provided configuration.
class SolidColorBackground extends StatelessWidget {
  final SolidColorConfigModel config;
  const SolidColorBackground({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: config.color);
  }
}
