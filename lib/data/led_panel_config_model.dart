import 'package:flutter/material.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel_direction_enum.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_typography.dart';

class LedPanelConfigModel {
  // Text Style
  final String text;
  final Color textColor;
  final double fontSize;
  final String fontFamily;
  final double letterSpacing;
  final double wordSpacing;
  final double glowRadius;
  // Animation and background
  final double speed;
  final LedPanelDirection direction;
  final Color backgroundColor;
  final Color ledsColor;

  const LedPanelConfigModel({
    // Text Style
    this.text = 'HELLO WORLD!',
    this.textColor = AppColors.primary,
    this.fontSize = 150.0,
    this.fontFamily = AppTypography.fontPixelifySans,
    this.letterSpacing = 0.0,
    this.wordSpacing = 0.0,
    this.glowRadius = 20.0,
    // Animation
    this.speed = 80.0,
    this.direction = .toLeft,
    this.backgroundColor = Colors.black,
    this.ledsColor = const Color(0xFFD9D9D9),
  });

  LedPanelConfigModel copyWith({
    // Text Style
    String? text,
    Color? textColor,
    double? fontSize,
    String? fontFamily,
    double? letterSpacing,
    double? wordSpacing,
    double? glowRadius,
    // Animation
    double? speed,
    LedPanelDirection? direction,
    Color? backgroundColor,
    Color? ledsColor,
  }) {
    return LedPanelConfigModel(
      // Text Style
      text: text ?? this.text,
      textColor: textColor ?? this.textColor,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      glowRadius: glowRadius ?? this.glowRadius,
      // Animation
      speed: speed ?? this.speed,
      direction: direction ?? this.direction,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      ledsColor: ledsColor ?? this.ledsColor,
    );
  }

  LedPanelConfigModel copyWithProportion(double proportion) {
    return copyWith(
      fontSize: fontSize * proportion,
      letterSpacing: letterSpacing * proportion,
      wordSpacing: wordSpacing * proportion,
      glowRadius: glowRadius * proportion,
      speed: speed * proportion,
    );
  }
}
