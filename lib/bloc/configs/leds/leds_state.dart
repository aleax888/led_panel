part of 'leds_cubit.dart';

@immutable
final class LedsState {
  final LedsConfigModel config;
  const LedsState({LedsConfigModel? config})
    : config = config ?? const LedsConfigModel();

  LedsState copyWith({LedsConfigModel? config}) {
    return LedsState(config: config ?? this.config);
  }
}
