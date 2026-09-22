import 'package:flutter/material.dart';
import 'package:led_panel/data/enums/dot_shape_enum.dart';

class BackgroundConfigModel {
  final Color color;
  final Color ledsColor;
  final DotShapeEnum ledsShape;

  const BackgroundConfigModel({
    this.color = Colors.black,
    this.ledsColor = const Color(0xFFD9D9D9),
    this.ledsShape = DotShapeEnum.circle,
  });

  BackgroundConfigModel copyWith({
    Color? color,
    Color? ledsColor,
    DotShapeEnum? ledsShape,
  }) {
    return BackgroundConfigModel(
      color: color ?? this.color,
      ledsColor: ledsColor ?? this.ledsColor,
      ledsShape: ledsShape ?? this.ledsShape,
    );
  }

  BackgroundConfigModel copyWithProportion(double proportion) {
    return copyWith();
  }

  factory BackgroundConfigModel.fromJson(Map<String, dynamic> json) {
    return BackgroundConfigModel(
      color: json['color'] != null ? Color(json['color'] as int) : Colors.black,
      ledsColor: json['leds_color'] != null
          ? Color(json['leds_color'] as int)
          : const Color(0xFFD9D9D9),
      ledsShape: json['leds_shape'] != null
          ? DotShapeEnum.values.firstWhere(
              (e) => e.name == json['leds_shape'] as String,
              orElse: () => DotShapeEnum.circle,
            )
          : DotShapeEnum.circle,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color.toARGB32(),
      'leds_color': ledsColor.toARGB32(),
      'leds_shape': ledsShape.name,
    };
  }
}
