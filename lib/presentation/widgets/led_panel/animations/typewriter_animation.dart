import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/typewriter_config_model.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/styled_animation.dart';

/// A widget that implements a typewriter animation for a LED panel.
class TypewriterAnimation extends StatefulWidget {
  final TextConfigModel textConfig;
  final TypewriterConfigModel animationConfig;
  const TypewriterAnimation({
    super.key,
    required this.textConfig,
    required this.animationConfig,
  });

  @override
  State<TypewriterAnimation> createState() => _TypewriterAnimationState();
}

class _TypewriterAnimationState extends State<TypewriterAnimation>
    with SingleTickerProviderStateMixin {
  final Random _random = Random();
  late final Ticker _ticker;
  Duration _cycleStart = Duration.zero;
  Duration _elapsed = Duration.zero;
  Duration _typingDuration = Duration.zero;
  List<String> _characters = const [];
  List<Duration> _characterDurations = const [];
  int _visibleCharacterCount = 0;

  @override
  void initState() {
    super.initState();
    _prepareMessage();
    _ticker = createTicker(_onTick)..start();
  }

  @override
  void didUpdateWidget(covariant TypewriterAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool animationConfigChanged =
        oldWidget.textConfig.message != widget.textConfig.message ||
        oldWidget.animationConfig.characterDuration !=
            widget.animationConfig.characterDuration ||
        oldWidget.animationConfig.characterDurationNoise !=
            widget.animationConfig.characterDurationNoise ||
        oldWidget.animationConfig.completionPause !=
            widget.animationConfig.completionPause;

    if (animationConfigChanged) {
      _cycleStart = _elapsed;
      _visibleCharacterCount = 0;
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
      child: StyledAnimation(
        textConfig: widget.textConfig.copyWith(
          message: _characters.take(_visibleCharacterCount).join(),
        ),
      ),
    );
  }

  void _onTick(Duration elapsed) {
    _elapsed = elapsed;
    final int characterCount = _characters.length;
    if (characterCount == 0) return;

    final Duration cycleDuration =
        _typingDuration + widget.animationConfig.completionPause;
    final Duration cycleElapsed = elapsed - _cycleStart;

    if (cycleElapsed >= cycleDuration) {
      _cycleStart = elapsed;
      _updateVisibleCharacterCount(0);
      return;
    }

    var nextCount = 0;
    var elapsedForCharacters = Duration.zero;
    while (nextCount < characterCount &&
        elapsedForCharacters + _characterDurations[nextCount] <= cycleElapsed) {
      elapsedForCharacters += _characterDurations[nextCount];
      nextCount++;
    }
    _updateVisibleCharacterCount(nextCount);
  }

  void _prepareMessage() {
    _characters = widget.textConfig.message.characters.toList();
    _characterDurations = [
      for (var index = 0; index < _characters.length; index++)
        widget.animationConfig.characterDuration +
            Duration(
              microseconds: _random.nextInt(
                widget.animationConfig.characterDurationNoise.inMicroseconds +
                    1,
              ),
            ),
    ];
    _typingDuration = _characterDurations.fold(
      Duration.zero,
      (total, duration) => total + duration,
    );
  }

  void _updateVisibleCharacterCount(int count) {
    if (!mounted || count == _visibleCharacterCount) return;
    setState(() => _visibleCharacterCount = count);
  }
}
