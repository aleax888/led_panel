import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';

/// A widget that displays styled text.
class StyledText extends StatefulWidget {
  final TextConfigModel textConfig;

  const StyledText({
    super.key,
    required this.textConfig,
  });

  @override
  State<StyledText> createState() => _StyledTextState();
}

class _StyledTextState extends State<StyledText> {
  @override
  Widget build(BuildContext context) {
    // Styled text ----------------------------------------------
    return Text(
      widget.textConfig.message,
      maxLines: 1,
      style: TextStyle(
        color: widget.textConfig.color,
        fontSize: widget.textConfig.fontSize,
        fontFamily: widget.textConfig.fontFamily,
        letterSpacing: widget.textConfig.letterSpacing,
        wordSpacing: widget.textConfig.wordSpacing,
        shadows: [
          Shadow(
            color: widget.textConfig.color,
            blurRadius: widget.textConfig.glowRadius,
          ),
        ],
      ),
      textAlign: .center,
    );
  }
}
