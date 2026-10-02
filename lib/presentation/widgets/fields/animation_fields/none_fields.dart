import 'package:flutter/material.dart';
import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/presentation/widgets/fields/animation_fields/animation_fields.dart';

/// Class that builds the fields for the "none" animation configuration, which has no configurable options.
class NoneFields extends AnimationFields {
  const NoneFields();

  @override
  List<Widget> build(
    BuildContext context,
    void Function(AnimationConfigModel) sync,
  ) => [];

  @override
  AnimationConfigModel currentConfig(BuildContext context) =>
      AnimationTypeEnum.none.defaultConfig;
}
