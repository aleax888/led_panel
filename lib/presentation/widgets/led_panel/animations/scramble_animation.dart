import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/scramble_config_model.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/styled_animation.dart';

/// A widget that implements a scramble animation for a LED panel.
class ScrambleAnimation extends StatefulWidget {
  final TextConfigModel textConfig;
  final ScrambleConfigModel animationConfig;
  const ScrambleAnimation({
    super.key,
    required this.textConfig,
    required this.animationConfig,
  });

  @override
  State<ScrambleAnimation> createState() => _ScrambleAnimationState();
}

class _ScrambleAnimationState extends State<ScrambleAnimation>
    with SingleTickerProviderStateMixin {
  final Random _random = Random();
  late final Ticker _ticker;
  Duration _cycleStart = Duration.zero;
  Duration _elapsed = Duration.zero;
  int _revealedCharacterCount = 0;
  List<String> _characters = const [];

  @override
  void initState() {
    super.initState();
    _prepareMessage();
    _ticker = createTicker(_onTick)..start();
  }

  @override
  void didUpdateWidget(covariant ScrambleAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool animationConfigChanged =
      oldWidget.textConfig.message != widget.textConfig.message ||
      oldWidget.animationConfig.characterDuration !=
        widget.animationConfig.characterDuration ||
      oldWidget.animationConfig.completionPause !=
        widget.animationConfig.completionPause ||
      oldWidget.animationConfig.scrambleCharacters !=
        widget.animationConfig.scrambleCharacters;

    if (animationConfigChanged) {
      _cycleStart = _elapsed;
      _revealedCharacterCount = 0;
      _prepareMessage();
    }
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
          /// Animated text ----------------------------------------------
          for (var index = 0; index < _characters.length; index++)
            StyledAnimation(
              textConfig: widget.textConfig.copyWith(
                message: _characterFor(index),
              ),
            ),
        ],
      ),
    );
  }

  void _onTick(Duration elapsed) {
    _elapsed = elapsed;
    final int characterCount = _characters.length;
    if (characterCount == 0) return;

    final Duration typingDuration =
      widget.animationConfig.characterDuration * characterCount;
    final Duration cycleDuration =
      typingDuration + widget.animationConfig.completionPause;
    final Duration cycleElapsed = elapsed - _cycleStart;

    if (cycleElapsed >= cycleDuration) {
      _cycleStart = elapsed;
      _updateRevealedCharacterCount(0);
      return;
    }

    final int nextCount =
      (cycleElapsed.inMicroseconds /
          widget.animationConfig.characterDuration.inMicroseconds)
            .floor()
            .clamp(0, characterCount);
    _updateRevealedCharacterCount(nextCount);
  }

  void _prepareMessage() {
    _characters = widget.textConfig.message.characters.toList();
  }

  String _characterFor(int index) {
    final String character = _characters[index];
    if (character.trim().isEmpty || index < _revealedCharacterCount) {
      return character;
    }
    final String scrambleCharacters = widget.animationConfig.scrambleCharacters;
    if (scrambleCharacters.isEmpty) return character;
    return scrambleCharacters[_random.nextInt(scrambleCharacters.length)];
  }

  void _updateRevealedCharacterCount(int count) {
    if (!mounted || count == _revealedCharacterCount) return;
    setState(() => _revealedCharacterCount = count);
  }
}
