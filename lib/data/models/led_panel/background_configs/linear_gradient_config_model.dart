import 'package:flutter/material.dart';

import 'package:led_panel/data/enums/background_type_enum.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';

class LinearGradientConfigModel implements BackgroundConfigModel {
  @override
  final BackgroundTypeEnum type = BackgroundTypeEnum.linearGradient;
  final LinearGradient gradient;

  const LinearGradientConfigModel({
    this.gradient = const LinearGradient(colors: [Colors.black, Colors.grey]),
  });

  @override
  LinearGradientConfigModel copyWith({LinearGradient? gradient}) {
    return LinearGradientConfigModel(gradient: gradient ?? this.gradient);
  }

  factory LinearGradientConfigModel.fromJson(Map<String, dynamic> json) {
    final gradientJson = json['gradient'] as Map<String, dynamic>?;

    if (gradientJson == null) {
      return const LinearGradientConfigModel();
    }

    final colors = (gradientJson['colors'] as List)
        .map((color) => Color(color as int))
        .toList();

    final beginJson = gradientJson['begin'] as Map<String, dynamic>;
    final endJson = gradientJson['end'] as Map<String, dynamic>;

    return LinearGradientConfigModel(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment(
          (beginJson['x'] as num).toDouble(),
          (beginJson['y'] as num).toDouble(),
        ),
        end: Alignment(
          (endJson['x'] as num).toDouble(),
          (endJson['y'] as num).toDouble(),
        ),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final begin = gradient.begin as Alignment;
    final end = gradient.end as Alignment;

    return {
      'type': type.name,
      'gradient': {
        'colors': gradient.colors.map((color) => color.toARGB32()).toList(),
        'begin': {'x': begin.x, 'y': begin.y},
        'end': {'x': end.x, 'y': end.y},
      },
    };
  }
}
