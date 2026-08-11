part of 'led_panel_bloc.dart';

@immutable
final class LedPanelState {
  final LedPanelConfigModel config;

  const LedPanelState({this.config = const LedPanelConfigModel()});

  LedPanelState copyWith({LedPanelConfigModel? config}) {
    return LedPanelState(config: config ?? this.config);
  }
}
