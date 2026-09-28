import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';

abstract class AnimationRenderer<T extends AnimationConfigModel> {
  const AnimationRenderer();

  Widget build(TextConfigModel text, T config, double width, double height);
}
