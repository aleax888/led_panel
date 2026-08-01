import 'package:flutter/material.dart';

// =============================================================================
// Modelo de configuración del panel
// =============================================================================

/// Agrupa todos los parámetros configurables del [LedPanel] en un objeto
/// inmutable y fácilmente transferible entre páginas.
class LedPanelConfig {
  final String text;
  final Color ledTextColor;
  final Color panelBackgroundColor;
  final Color borderColor;
  final double fontSize;
  final double scrollSpeedPixelsPerSecond;
  final double ledGlowRadius;
  final FontWeight fontWeight;
  final double borderRadius;

  const LedPanelConfig({
    this.text =
        '  ★  BIENVENIDOS  •  ABIERTO 24 HORAS  •  OFERTAS DEL DÍA  ★  ',
    this.ledTextColor = const Color(0xFFFF3300),
    this.panelBackgroundColor = const Color(0xFF0A0A0A),
    this.borderColor = const Color(0xFF333333),
    this.fontSize = 28.0,
    this.scrollSpeedPixelsPerSecond = 80.0,
    this.ledGlowRadius = 12.0,
    this.fontWeight = FontWeight.bold,
    this.borderRadius = 6.0,
  });

  LedPanelConfig copyWith({
    String? text,
    Color? ledTextColor,
    Color? panelBackgroundColor,
    Color? borderColor,
    double? fontSize,
    double? scrollSpeedPixelsPerSecond,
    double? ledGlowRadius,
    FontWeight? fontWeight,
    double? borderRadius,
  }) {
    return LedPanelConfig(
      text: text ?? this.text,
      ledTextColor: ledTextColor ?? this.ledTextColor,
      panelBackgroundColor: panelBackgroundColor ?? this.panelBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      fontSize: fontSize ?? this.fontSize,
      scrollSpeedPixelsPerSecond:
          scrollSpeedPixelsPerSecond ?? this.scrollSpeedPixelsPerSecond,
      ledGlowRadius: ledGlowRadius ?? this.ledGlowRadius,
      fontWeight: fontWeight ?? this.fontWeight,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
