import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_typography.dart';

class LedPanelConfigModel {
  final double speed;
  final String text;
  final Color color;
  final double fontSize;
  final String fontFamily;

  const LedPanelConfigModel({
    this.speed = 80.0,
    this.text = 'HELLO WORLD!',
    this.color = AppColors.primary,
    this.fontSize = AppTypography.sizeDisplay,
    this.fontFamily = AppTypography.fontPixelifySans,
  });

  LedPanelConfigModel copyWith({
    double? speed,
    String? text,
    Color? color,
    double? fontSize,
    String? fontFamily,
  }) {
    return LedPanelConfigModel(
      speed: speed ?? this.speed,
      text: text ?? this.text,
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }
}
