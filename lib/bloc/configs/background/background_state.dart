part of 'background_cubit.dart';

@immutable
final class BackgroundState {
  final BackgroundConfigModel config;
  const BackgroundState({BackgroundConfigModel? config})
    : config = config ?? const BackgroundConfigModel();

  BackgroundState copyWith({BackgroundConfigModel? config}) {
    return BackgroundState(config: config ?? this.config);
  }
}
