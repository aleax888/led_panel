import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/background_configs/solid_color_config_model.dart';

class SolidColorBackground extends StatelessWidget {
  final SolidColorConfigModel config;
  const SolidColorBackground({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: config.color);
  }
}
