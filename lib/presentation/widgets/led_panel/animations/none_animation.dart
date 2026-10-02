import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/styled_animation.dart';

/// A widget that implements a "none" animation for a LED panel, which simply displays the text without any animation.
class NoneAnimation extends StatelessWidget {
  final TextConfigModel textConfig;
  const NoneAnimation({super.key, required this.textConfig});

  @override
  Widget build(BuildContext context) {
    return StyledAnimation(textConfig: textConfig);
  }
}
