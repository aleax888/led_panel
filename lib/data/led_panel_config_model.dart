import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_colors.dart';

class LedPanelConfigModel {
  final String text;
  final Color color;
  final double fontSize;
  final double speed;

  const LedPanelConfigModel({
    this.text = 'HELLO WORLD!',
    this.color = AppColors.primary,
    this.fontSize = 28.0,
    this.speed = 80.0,
  });

  LedPanelConfigModel copyWith({
    String? text,
    Color? color,
    double? fontSize,
    double? speed,
  }) {
    return LedPanelConfigModel(
      text: text ?? this.text,
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      speed: speed ?? this.speed,
    );
  }
}
