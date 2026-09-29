import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';

abstract class BackgroundFields {
  const BackgroundFields();
  List<Widget> build(
    BuildContext context,
    void Function(BackgroundConfigModel) sync,
  );
  BackgroundConfigModel currentConfig(BuildContext context);
}
