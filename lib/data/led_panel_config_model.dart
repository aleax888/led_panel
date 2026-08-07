import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_typography.dart';

class LedPanelConfigModel {
  final double speed;
  final String text;
  final Color color;
  final double fontSize;
  final String fontFamily;
  final double letterSpacing;
  final double wordSpacing;
  final double glowRadius;

  const LedPanelConfigModel({
    this.speed = 80.0,
    this.text = 'HELLO WORLD!',
    this.color = AppColors.primary,
    this.fontSize = 150.0,
    this.fontFamily = AppTypography.fontPixelifySans,
    this.letterSpacing = 0.0,
    this.wordSpacing = 0.0,
    this.glowRadius = 0.0,
  });

  LedPanelConfigModel copyWith({
    double? speed,
    String? text,
    Color? color,
    double? fontSize,
    String? fontFamily,
    double? letterSpacing,
    double? wordSpacing,
    double? glowRadius,
  }) {
    return LedPanelConfigModel(
      speed: speed ?? this.speed,
      text: text ?? this.text,
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      glowRadius: glowRadius ?? this.glowRadius,
    );
  }
}
