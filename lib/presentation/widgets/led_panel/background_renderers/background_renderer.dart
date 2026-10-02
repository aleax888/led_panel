import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';

/// An abstract class that defines the interface for rendering backgrounds on a LED panel.
abstract class BackgroundRenderer<T extends BackgroundConfigModel> {
  const BackgroundRenderer();

  Widget build(T config);
}
