import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/background_configs/image_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/background_renderers/background_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/backgrounds/image_background.dart';

/// A concrete implementation of BackgroundRenderer for rendering image backgrounds on a LED panel.
class ImageRenderer extends BackgroundRenderer<ImageConfigModel> {
  const ImageRenderer();

  @override
  Widget build(config) => ImageBackground(config: config);
}
