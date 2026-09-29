import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';

abstract class BackgroundRenderer<T extends BackgroundConfigModel> {
  const BackgroundRenderer();

  Widget build(T config);
}
