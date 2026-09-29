part of 'linear_gradient_cubit.dart';

@immutable
final class LinearGradientState {
  final LinearGradientConfigModel config;
  const LinearGradientState({LinearGradientConfigModel? config})
    : config = config ?? const LinearGradientConfigModel();

  LinearGradientState copyWith({LinearGradientConfigModel? config}) {
    return LinearGradientState(config: config ?? this.config);
  }
}
