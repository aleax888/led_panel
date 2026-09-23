import 'package:flutter/material.dart';
import 'package:led_panel/data/models/animations/scramble_config_model.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/styled_text.dart';

class ScrambleText extends StatefulWidget {
  final TextConfigModel textConfig;
  final ScrambleConfigModel animationConfig;
  const ScrambleText({
    super.key,
    required this.textConfig,
    required this.animationConfig,
  });

  @override
  State<ScrambleText> createState() => _ScrambleTextState();
}

class _ScrambleTextState extends State<ScrambleText> {
  @override
  Widget build(BuildContext context) {
    return StyledText(textConfig: widget.textConfig);
  }
}
