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
final class LedPanelTextConfigChanged extends LedPanelEvent {
  final TextConfigModel config;
  const LedPanelTextConfigChanged(this.config);
}

// Animation ----------------------------------------------
final class LedPanelAnimationTypeChanged extends LedPanelEvent {
  final AnimationConfigModel config;
  const LedPanelAnimationTypeChanged(this.config);
}

final class LedPanelAnimationConfigChanged extends LedPanelEvent {
  final AnimationConfigModel config;
  const LedPanelAnimationConfigChanged(this.config);
}

// Background ----------------------------------------------
final class LedPanelBackgroundTypeChanged extends LedPanelEvent {
  final BackgroundConfigModel config;
  const LedPanelBackgroundTypeChanged(this.config);
}

final class LedPanelBackgroundConfigChanged extends LedPanelEvent {
  final BackgroundConfigModel config;
  const LedPanelBackgroundConfigChanged(this.config);
}

// Leds ----------------------------------------------
final class LedPanelLedsConfigChanged extends LedPanelEvent {
  final LedsConfigModel config;
  const LedPanelLedsConfigChanged(this.config);
}
