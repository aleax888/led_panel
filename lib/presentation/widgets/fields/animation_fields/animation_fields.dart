import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';

/// Abstract class that defines the interface for building animation fields in the LED panel configuration.
abstract class AnimationFields {
  const AnimationFields();
  AnimationConfigModel currentConfig(BuildContext context);
  List<Widget> build(
    BuildContext context,
    void Function(AnimationConfigModel) sync,
  );
}
