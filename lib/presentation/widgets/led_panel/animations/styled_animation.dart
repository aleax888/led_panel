import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';

/// A widget that displays styled text.
class StyledAnimation extends StatelessWidget {
  final TextConfigModel textConfig;
  final int? maxLines;

  const StyledAnimation({super.key, required this.textConfig, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    // Styled text ----------------------------------------------
    return Text(
      textConfig.message,
      maxLines: maxLines,
      style: TextStyle(
        color: textConfig.color,
        fontSize: textConfig.fontSize,
        fontFamily: textConfig.fontFamily,
        letterSpacing: textConfig.letterSpacing,
        wordSpacing: textConfig.wordSpacing,
        shadows: [
          Shadow(color: textConfig.color, blurRadius: textConfig.glowRadius),
        ],
      ),
      textAlign: .center,
    );
  }
}
