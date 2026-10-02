import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/none_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/animation_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/none_animation.dart';

/// A concrete implementation of AnimationRenderer for rendering a "none" animation on a LED panel.
class NoneRenderer extends AnimationRenderer<NoneConfigModel> {
  const NoneRenderer();

  @override
  Widget build(text, config, width, height) => NoneAnimation(textConfig: text);
}
