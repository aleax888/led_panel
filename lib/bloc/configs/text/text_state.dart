part of 'text_cubit.dart';

@immutable
final class TextState {
  final TextConfigModel config;
  const TextState({TextConfigModel? config})
    : config = config ?? const TextConfigModel();

  TextState copyWith({TextConfigModel? config}) {
    return TextState(config: config ?? this.config);
  }
}
