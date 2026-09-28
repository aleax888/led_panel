import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/wave_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/animation_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/wave_animation.dart';

class WaveRenderer extends AnimationRenderer<WaveConfigModel> {
  const WaveRenderer();

  @override
  Widget build(text, config, width, height) =>
      WaveAnimation(textConfig: text, animationConfig: config);
}
