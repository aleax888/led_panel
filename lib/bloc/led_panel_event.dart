part of 'led_panel_bloc.dart';

@immutable
sealed class LedPanelEvent {
  const LedPanelEvent();
}

final class LedPanelTextChanged extends LedPanelEvent {
  final String text;
  const LedPanelTextChanged(this.text);
}

final class LedPanelColorChanged extends LedPanelEvent {
  final Color color;

  const LedPanelColorChanged(this.color);
}

final class LedPanelSpeedChanged extends LedPanelEvent {
  final double speed;
  const LedPanelSpeedChanged(this.speed);
}

final class LedPanelFontSizeChanged extends LedPanelEvent {
  final double fontSize;
  const LedPanelFontSizeChanged(this.fontSize);
}

final class LedPanelGlowRadiusChanged extends LedPanelEvent {
  final double glowRadius;
  const LedPanelGlowRadiusChanged(this.glowRadius);
}

final class LedPanelBorderRadiusChanged extends LedPanelEvent {
  final double borderRadius;
  const LedPanelBorderRadiusChanged(this.borderRadius);
}

final class LedPanelFontWeightChanged extends LedPanelEvent {
  final FontWeight fontWeight;
  const LedPanelFontWeightChanged(this.fontWeight);
}
