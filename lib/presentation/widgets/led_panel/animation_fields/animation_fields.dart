import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';

abstract class AnimationFields {
  const AnimationFields();
  AnimationConfigModel currentConfig(BuildContext context);
  List<Widget> build(
    BuildContext context,
    void Function(AnimationConfigModel) sync,
  );
}
