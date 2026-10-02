import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/marquee_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/animation_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/marquee_animation.dart';

/// A concrete implementation of AnimationRenderer for rendering marquee animations on a LED panel.
class MarqueeRenderer extends AnimationRenderer<MarqueeConfigModel> {
  const MarqueeRenderer();

  @override
  Widget build(text, config, width, height) => MarqueeAnimation(
    textConfig: text,
    animationConfig: config,
    panelWidth: width,
  );
}
