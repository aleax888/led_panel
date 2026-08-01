part of 'led_panel_bloc.dart';

@immutable
final class LedPanelState {
  final LedPanelConfig config;

  const LedPanelState({this.config = const LedPanelConfig()});

  LedPanelState copyWith({LedPanelConfig? config}) {
    return LedPanelState(config: config ?? this.config);
  }
}
