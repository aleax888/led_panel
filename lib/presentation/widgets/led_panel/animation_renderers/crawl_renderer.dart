import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/crawl_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/animation_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/crawl_animation.dart';

/// A concrete implementation of AnimationRenderer for rendering crawl animations on a LED panel.
class CrawlRenderer extends AnimationRenderer<CrawlConfigModel> {
  const CrawlRenderer();

  @override
  Widget build(text, config, width, height) => CrawlAnimation(
    textConfig: text,
    animationConfig: config,
    panelWidth: width,
    panelHeight: height,
  );
}
