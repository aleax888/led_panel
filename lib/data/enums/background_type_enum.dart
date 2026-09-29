import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/background_configs/image_config_model.dart';
import 'package:led_panel/data/models/led_panel/background_configs/linear_gradient_config_model.dart';
import 'package:led_panel/data/models/led_panel/background_configs/solid_color_config_model.dart';
import 'package:led_panel/presentation/widgets/fields/background_fields/background_fields.dart';
import 'package:led_panel/presentation/widgets/fields/background_fields/image_fields.dart';
import 'package:led_panel/presentation/widgets/fields/background_fields/linear_gradient_fields.dart';
import 'package:led_panel/presentation/widgets/fields/background_fields/solid_color_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/background_renderers/background_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/background_renderers/image_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/background_renderers/linear_gradient_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/background_renderers/solid_color_renderer.dart';

enum BackgroundTypeEnum {
  solidColor(
    label: 'Solid',
    icon: Icons.color_lens_outlined,
    fromJson: SolidColorConfigModel.fromJson,
    fields: SolidColorFields(),
    renderer: SolidColorRenderer(),
  ),
  linearGradient(
    label: 'Gradient',
    icon: Icons.gradient_outlined,
    fromJson: LinearGradientConfigModel.fromJson,
    fields: LinearGradientFields(),
    renderer: LinearGradientRenderer(),
  ),
  image(
    label: 'Image',
    icon: Icons.image,
    fromJson: ImageConfigModel.fromJson,
    fields: ImageFields(),
    renderer: ImageRenderer(),
  );

  const BackgroundTypeEnum({
    required this.label,
    required this.icon,
    required this.fromJson,
    required this.fields,
    required this.renderer,
  });

  final String label;
  final IconData icon;
  final Function fromJson;
  final BackgroundFields fields;
  final BackgroundRenderer renderer;
}
