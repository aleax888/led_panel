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

final class LedPanelSpeedChanged extends LedPanelEvent {
  final double speed;
  const LedPanelSpeedChanged(this.speed);
}

final class LedPanelDirectionChanged extends LedPanelEvent {
  final LedPanelDirectionEnum direction;
  const LedPanelDirectionChanged(this.direction);
}

final class LedPanelBackgroundColorChanged extends LedPanelEvent {
  final Color color;
  const LedPanelBackgroundColorChanged(this.color);
}

final class LedPanelLedsColorChanged extends LedPanelEvent {
  final Color color;
  const LedPanelLedsColorChanged(this.color);
}
