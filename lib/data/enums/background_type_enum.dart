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

/// Enum representing different types of backgrounds for the LED panel.
enum BackgroundTypeEnum {
  /// Solid color background
  solidColor(
    label: 'Solid',
    icon: Icons.color_lens_outlined,
    fromJson: SolidColorConfigModel.fromJson,
    fields: SolidColorFields(),
    renderer: SolidColorRenderer(),
  ),

  /// Linear gradient background
  linearGradient(
    label: 'Gradient',
    icon: Icons.gradient_outlined,
    fromJson: LinearGradientConfigModel.fromJson,
    fields: LinearGradientFields(),
    renderer: LinearGradientRenderer(),
  ),

  /// Image background
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

  /// The human-readable label for the background type.
  final String label;
  /// The icon representing the background type, used in the UI.
  final IconData icon;
  /// A function that takes a JSON map and returns an instance of the corresponding background configuration model.
  final Function fromJson;
  /// The fields widget associated with the background type, used for user input.
  final BackgroundFields fields;
  /// The renderer widget associated with the background type, used to display the background.
  final BackgroundRenderer renderer;
}
