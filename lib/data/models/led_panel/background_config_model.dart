import 'package:flutter/material.dart';

class BackgroundConfigModel {
  final Color color;
  final Color ledsColor;

  const BackgroundConfigModel({
    this.color = Colors.black,
    this.ledsColor = const Color(0xFFD9D9D9),
  });

  BackgroundConfigModel copyWith({Color? color, Color? ledsColor}) {
    return BackgroundConfigModel(
      color: color ?? this.color,
      ledsColor: ledsColor ?? this.ledsColor,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {'color': color.toARGB32(), 'leds_color': ledsColor.toARGB32()};
  }
}
