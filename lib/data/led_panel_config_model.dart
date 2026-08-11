import 'package:flutter/material.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel_direction_enum.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_typography.dart';

class LedPanelConfigModel {
  final String? id;
  final DateTime? createdAt;
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
  final LedPanelDirectionEnum direction;
  final Color backgroundColor;
  final Color ledsColor;

  const LedPanelConfigModel({
    this.id,
    this.createdAt,
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
    String? id,
    DateTime? createdAt,
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
    LedPanelDirectionEnum? direction,
    Color? backgroundColor,
    Color? ledsColor,
  }) {
    return LedPanelConfigModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
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

  factory LedPanelConfigModel.fromJson(Map<String, dynamic> json) {
    return LedPanelConfigModel(
      id: json['id'],
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      // Text Style
      text: json['text'] as String? ?? 'HELLO WORLD!',
      textColor: json['text_color'] != null
          ? Color(json['text_color'] as int)
          : AppColors.primary,
      fontSize: (json['font_size'] as num?)?.toDouble() ?? 150.0,
      fontFamily:
          json['font_family'] as String? ?? AppTypography.fontPixelifySans,
      letterSpacing: (json['letter_spacing'] as num?)?.toDouble() ?? 0.0,
      wordSpacing: (json['word_spacing'] as num?)?.toDouble() ?? 0.0,
      glowRadius: (json['glow_radius'] as num?)?.toDouble() ?? 20.0,
      // Animation
      speed: (json['speed'] as num?)?.toDouble() ?? 80.0,
      direction: LedPanelDirectionEnum.values.firstWhere(
        (e) => e.name == json['direction'],
        orElse: () => LedPanelDirectionEnum.toLeft,
      ),
      backgroundColor: json['background_color'] != null
          ? Color(json['background_color'] as int)
          : Colors.black,
      ledsColor: json['leds_color'] != null
          ? Color(json['leds_color'] as int)
          : const Color(0xFFD9D9D9),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      // Text Style
      'text': text,
      'text_color': textColor.toARGB32(),
      'font_size': fontSize,
      'font_family': fontFamily,
      'letter_spacing': letterSpacing,
      'word_spacing': wordSpacing,
      'glow_radius': glowRadius,
      // Animation
      'speed': speed,
      'direction': direction.name,
      'background_color': backgroundColor.toARGB32(),
      'leds_color': ledsColor.toARGB32(),
    };
  }
}
