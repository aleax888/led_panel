import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

class _ScrambleTextState extends State<ScrambleText>
    with SingleTickerProviderStateMixin {
  static const Duration _characterDuration = Duration(milliseconds: 80);
  static const Duration _completionPause = Duration(seconds: 1);
  static const String _scrambleCharacters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#%&*+-=?';

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
  void didUpdateWidget(covariant ScrambleText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.textConfig.message != widget.textConfig.message) {
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
          for (var index = 0; index < _characters.length; index++)
            StyledText(
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

    final Duration typingDuration = _characterDuration * characterCount;
    final Duration cycleDuration = typingDuration + _completionPause;
    final Duration cycleElapsed = elapsed - _cycleStart;

    if (cycleElapsed >= cycleDuration) {
      _cycleStart = elapsed;
      _updateRevealedCharacterCount(0);
      return;
    }

    final int nextCount =
        (cycleElapsed.inMicroseconds / _characterDuration.inMicroseconds)
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
    return _scrambleCharacters[_random.nextInt(_scrambleCharacters.length)];
  }

  void _updateRevealedCharacterCount(int count) {
    if (!mounted || count == _revealedCharacterCount) return;
    setState(() => _revealedCharacterCount = count);
  }
}
