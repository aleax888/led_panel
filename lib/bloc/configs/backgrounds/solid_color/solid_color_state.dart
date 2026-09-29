part of 'solid_color_cubit.dart';

@immutable
final class SolidColorState {
  final SolidColorConfigModel config;
  const SolidColorState({SolidColorConfigModel? config})
    : config = config ?? const SolidColorConfigModel();

  SolidColorState copyWith({SolidColorConfigModel? config}) {
    return SolidColorState(config: config ?? this.config);
  }
}
