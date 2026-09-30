import 'package:flutter/material.dart';

import 'package:led_panel/data/models/led_panel/background_configs/linear_gradient_config_model.dart';

class LinearGradientBackground extends StatelessWidget {
  final LinearGradientConfigModel config;

  const LinearGradientBackground({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: config.colors,
          stops: config.stops,
          transform: GradientRotation(config.tilt),
        ),
      ),
    );
  }
}
