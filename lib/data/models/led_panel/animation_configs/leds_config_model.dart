import 'package:flutter/material.dart';
import 'package:led_panel/data/enums/dot_shape_enum.dart';

class LedsConfigModel {
  final Color color;
  final DotShapeEnum shape;
  final double size;
  final double padding;

  const LedsConfigModel({
    this.color = const Color(0x40D9D9D9),
    this.shape = .circle,
    this.size = 15.0,
    this.padding = 2.0,
  });

  LedsConfigModel copyWith({
    Color? color,
    DotShapeEnum? shape,
    double? size,
    double? padding,
  }) {
    return LedsConfigModel(
      color: color ?? this.color,
      shape: shape ?? this.shape,
      size: size ?? this.size,
      padding: padding ?? this.padding,
    );
  }

  LedsConfigModel copyWithProportion(double proportion) {
    return copyWith(size: size * proportion, padding: padding * proportion);
  }

  factory LedsConfigModel.fromJson(Map<String, dynamic> json) {
    return LedsConfigModel(
      color: json['color'] != null
          ? Color(json['color'] as int)
          : const Color(0xFFD9D9D9),
      shape: DotShapeEnum.values.firstWhere(
        (shape) => shape.name == json['shape'],
        orElse: () => .circle,
      ),
      size: (json['size'] as num?)?.toDouble() ?? 10.0,
      padding: (json['padding'] as num?)?.toDouble() ?? 2.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color.toARGB32(),
      'shape': shape.name,
      'size': size,
      'padding': padding,
    };
  }
}
