import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/background_configs/linear_gradient_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/background_renderers/background_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/backgrounds/linear_gradient_background.dart';

class LinearGradientRenderer
    extends BackgroundRenderer<LinearGradientConfigModel> {
  const LinearGradientRenderer();

  @override
  Widget build(config) => LinearGradientBackground(config: config);
}
