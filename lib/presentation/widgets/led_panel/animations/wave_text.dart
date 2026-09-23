import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:led_panel/data/models/animations/wave_config_model.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/styled_text.dart';

class WaveText extends StatefulWidget {
  final TextConfigModel textConfig;
  final WaveConfigModel animationConfig;
  const WaveText({
    super.key,
    required this.textConfig,
    required this.animationConfig,
  });

  @override
  State<WaveText> createState() => _WaveTextState();
}

class _WaveTextState extends State<WaveText>
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
            Transform.translate(
              offset: Offset(
                0,
                sin(
                      _elapsed * widget.animationConfig.frequency -
                          index * widget.animationConfig.phaseStep,
                    ) *
                    widget.animationConfig.amplitude,
              ),
              child: StyledText(
                textConfig: widget.textConfig.copyWith(message: character),
              ),
            ),
        ],
      ),
    );
  }
}
