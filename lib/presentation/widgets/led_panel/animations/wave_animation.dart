import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/wave_config_model.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/styled_animation.dart';

/// A widget that implements a wave animation for a LED panel.
class WaveAnimation extends StatefulWidget {
  final TextConfigModel textConfig;
  final WaveConfigModel animationConfig;
  const WaveAnimation({
    super.key,
    required this.textConfig,
    required this.animationConfig,
  });

  @override
  State<WaveAnimation> createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  double _elapsed = 0.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      if (!mounted) return;
      setState(() => _elapsed = elapsed.inMicroseconds / 1000000);
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minWidth: 0,
      maxWidth: double.infinity,
      minHeight: 0,
      maxHeight: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (final (index, character)
              in widget.textConfig.message.characters.indexed)
            // Animation for each character in the message, applying a vertical translation based on a sine wave function.
            Transform.translate(
              offset: Offset(
                0,
                sin(
                      _elapsed * widget.animationConfig.frequency -
                          index * widget.animationConfig.phaseStep,
                    ) *
                    widget.animationConfig.amplitude,
              ),
              child: StyledAnimation(
                textConfig: widget.textConfig.copyWith(message: character),
              ),
            ),
        ],
      ),
    );
  }
}
