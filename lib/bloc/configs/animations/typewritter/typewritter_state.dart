part of 'typewritter_cubit.dart';

@immutable
final class TypewritterState {
  final TypewriterConfigModel config;
  const TypewritterState({TypewriterConfigModel? config})
    : config = config ?? const TypewriterConfigModel();

  TypewritterState copyWith({TypewriterConfigModel? config}) {
    return TypewritterState(config: config ?? this.config);
  }
}
