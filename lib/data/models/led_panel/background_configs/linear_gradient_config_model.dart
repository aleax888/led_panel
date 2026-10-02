import 'package:flutter/material.dart';

import 'package:led_panel/data/enums/background_type_enum.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';
import 'package:led_panel/utils/angle_handler.dart';

/// Model class representing the configuration for a linear gradient background.
class LinearGradientConfigModel implements BackgroundConfigModel {
  /// The type of background, which is set to [BackgroundTypeEnum.linearGradient].
  @override
  final BackgroundTypeEnum type = BackgroundTypeEnum.linearGradient;
  /// The list of colors used in the linear gradient.
  final List<Color> colors;
  /// The list of stops corresponding to the colors in the linear gradient, determining where each color starts and ends.
  final List<double> stops;
  /// The tilt angle of the linear gradient, affecting the direction of the gradient.
  final double tilt;

  /// Returns the tilt angle in degrees, which is useful for understanding the gradient's orientation in a more intuitive unit.
  double get tiltDegrees => AngleHandler.radiansToDegrees(tilt);

  const LinearGradientConfigModel({
    this.colors = const [Colors.black, Colors.grey],
    this.stops = const [0.25, 1.0],
    this.tilt = 0.0,
  });

  @override
  LinearGradientConfigModel copyWith({
    List<Color>? colors,
    List<double>? stops,
    double? tilt,
  }) {
    return LinearGradientConfigModel(
      colors: colors ?? this.colors,
      stops: stops ?? this.stops,
      tilt: tilt ?? this.tilt,
    );
  }

  factory LinearGradientConfigModel.fromJson(Map<String, dynamic> json) {
    return LinearGradientConfigModel(
      colors: (json['colors'] as List<dynamic>?)
              ?.map((color) => Color(color as int))
              .toList() ??
          const [Colors.black, Colors.grey],
      stops: (json['stops'] as List<dynamic>?)
              ?.map((stop) => (stop as num).toDouble())
              .toList() ??
          const [0.0, 1.0],
      tilt: (json['tilt'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'colors': colors.map((color) => color.toARGB32()).toList(),
      'stops': stops,
      'tilt': tilt,
    };
  }
}
