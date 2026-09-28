import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/typewriter_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/animation_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/typewriter_animation.dart';

class TypewriterRenderer extends AnimationRenderer<TypewriterConfigModel> {
  const TypewriterRenderer();

  @override
  Widget build(text, config, width, height) =>
      TypewriterAnimation(textConfig: text, animationConfig: config);
}
