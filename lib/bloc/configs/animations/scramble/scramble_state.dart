part of 'scramble_cubit.dart';

@immutable
final class ScrambleState {
  final ScrambleConfigModel config;
  const ScrambleState({ScrambleConfigModel? config})
    : config = config ?? const ScrambleConfigModel();

  ScrambleState copyWith({ScrambleConfigModel? config}) {
    return ScrambleState(config: config ?? this.config);
  }
}
