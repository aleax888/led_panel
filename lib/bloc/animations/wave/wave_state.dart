part of 'wave_cubit.dart';

@immutable
final class WaveState {
  final WaveConfigModel config;
  const WaveState({this.config = const WaveConfigModel()});

  WaveState copyWith({WaveConfigModel? config}) {
    return WaveState(config: config ?? this.config);
  }
}
