import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_typography.dart';

/// Model class representing the configuration for text display on the LED panel.
class TextConfigModel {
  /// The message to be displayed on the LED panel.
  final String message;
  /// The color of the text, represented as a [Color].
  final Color color;
  /// The font size of the text, affecting its visual appearance.
  final double fontSize;
  /// The font family used for the text, determining its style.
  final String fontFamily;
  /// The letter spacing for the text, affecting the space between individual letters.
  final double letterSpacing;
  /// The word spacing for the text, affecting the space between words.
  final double wordSpacing;
  /// The glow radius for the text, affecting the intensity of the glow effect around the text.
  final double glowRadius;

  const TextConfigModel({
    this.message = 'HELLO WORLD!',
    this.color = AppColors.primary,
    this.fontSize = 150.0,
    this.fontFamily = AppTypography.fontPixelifySans,
    this.letterSpacing = 0.0,
    this.wordSpacing = 0.0,
    this.glowRadius = 20.0,
  });

  TextConfigModel copyWith({
    String? message,
    Color? color,
    double? fontSize,
    String? fontFamily,
    double? letterSpacing,
    double? wordSpacing,
    double? glowRadius,
  }) {
    return TextConfigModel(
      message: message ?? this.message,
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      glowRadius: glowRadius ?? this.glowRadius,
    );
  }

  TextConfigModel copyWithProportion(double proportion) {
    return copyWith(
      fontSize: fontSize * proportion,
      letterSpacing: letterSpacing * proportion,
      wordSpacing: wordSpacing * proportion,
      glowRadius: glowRadius * proportion,
    );
  }

  factory TextConfigModel.fromJson(Map<String, dynamic> json) {
    return TextConfigModel(
      message: json['message'] as String? ?? 'HELLO WORLD!',
      color: json['color'] != null
          ? Color(json['color'] as int)
          : AppColors.primary,
      fontSize: (json['font_size'] as num?)?.toDouble() ?? 150.0,
      fontFamily:
          json['font_family'] as String? ?? AppTypography.fontPixelifySans,
      letterSpacing: (json['letter_spacing'] as num?)?.toDouble() ?? 0.0,
      wordSpacing: (json['word_spacing'] as num?)?.toDouble() ?? 0.0,
      glowRadius: (json['glow_radius'] as num?)?.toDouble() ?? 20.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'color': color.toARGB32(),
      'font_size': fontSize,
      'font_family': fontFamily,
      'letter_spacing': letterSpacing,
      'word_spacing': wordSpacing,
      'glow_radius': glowRadius,
    };
  }
}
