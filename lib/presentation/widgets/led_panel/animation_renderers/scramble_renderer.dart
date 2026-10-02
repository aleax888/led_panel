import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/scramble_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/animation_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/scramble_animation.dart';

/// A concrete implementation of AnimationRenderer for rendering scramble animations on a LED panel.
class ScrambleRenderer extends AnimationRenderer<ScrambleConfigModel> {
  const ScrambleRenderer();

  @override
  Widget build(text, config, width, height) =>
      ScrambleAnimation(textConfig: text, animationConfig: config);
}
