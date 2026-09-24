part of 'led_panel_bloc.dart';

@immutable
sealed class LedPanelEvent {
  const LedPanelEvent();
}

final class LedPanelUnselected extends LedPanelEvent {}

final class LedPanelConfigSelected extends LedPanelEvent {
  final LedPanelConfigModel? config;
  const LedPanelConfigSelected(this.config);
}

// Text ----------------------------------------------
final class LedPanelTextChanged extends LedPanelEvent {
  final String text;
  const LedPanelTextChanged(this.text);
}

final class LedPanelTextColorChanged extends LedPanelEvent {
  final Color color;

  const LedPanelTextColorChanged(this.color);
}

final class LedPanelFontSizeChanged extends LedPanelEvent {
  final double fontSize;
  const LedPanelFontSizeChanged(this.fontSize);
}

final class LedPanelFontFamilyChanged extends LedPanelEvent {
  final String fontFamily;
  const LedPanelFontFamilyChanged(this.fontFamily);
}

final class LedPanelLetterSpacingChanged extends LedPanelEvent {
  final double letterSpacing;
  const LedPanelLetterSpacingChanged(this.letterSpacing);
}

final class LedPanelWordSpacingChanged extends LedPanelEvent {
  final double wordSpacing;
  const LedPanelWordSpacingChanged(this.wordSpacing);
}

final class LedPanelGlowRadiusChanged extends LedPanelEvent {
  final double glowRadius;
  const LedPanelGlowRadiusChanged(this.glowRadius);
}

// Animation ----------------------------------------------
final class LedPanelAnimationTypeChanged extends LedPanelEvent {
  final AnimationTypeEnum type;
  const LedPanelAnimationTypeChanged(this.type);
}

// * Marquee ----------------------------------------------
final class LedPanelSpeedChanged extends LedPanelEvent {
  final double speed;
  const LedPanelSpeedChanged(this.speed);
}

final class LedPanelDirectionChanged extends LedPanelEvent {
  final MarqueeDirectionEnum direction;
  const LedPanelDirectionChanged(this.direction);
}

// * Typewriter ----------------------------------------------
final class LedPanelCharacterDurationChanged extends LedPanelEvent {
  final int characterDuration;
  const LedPanelCharacterDurationChanged(this.characterDuration);
}

final class LedPanelCharacterDurationNoiseChanged extends LedPanelEvent {
  final int characterDurationNoise;
  const LedPanelCharacterDurationNoiseChanged(this.characterDurationNoise);
}

final class LedPanelCompletionPauseChanged extends LedPanelEvent {
  final int completionPause;
  const LedPanelCompletionPauseChanged(this.completionPause);
}

// * Wave ----------------------------------------------
// * Scramble ----------------------------------------------
// * Crawl ----------------------------------------------

// Background ----------------------------------------------
final class LedPanelBackgroundColorChanged extends LedPanelEvent {
  final Color color;
  const LedPanelBackgroundColorChanged(this.color);
}

final class LedPanelLedsShapeChanged extends LedPanelEvent {
  final DotShapeEnum shape;
  const LedPanelLedsShapeChanged(this.shape);
}

final class LedPanelLedsColorChanged extends LedPanelEvent {
  final Color color;
  const LedPanelLedsColorChanged(this.color);
}
