import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/background_configs/solid_color_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/background_renderers/background_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/backgrounds/solid_color_background.dart';

class SolidColorRenderer extends BackgroundRenderer<SolidColorConfigModel> {
  const SolidColorRenderer();

  @override
  Widget build(config) => SolidColorBackground(config: config);
}
