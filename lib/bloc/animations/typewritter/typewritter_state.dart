part of 'typewritter_cubit.dart';

@immutable
final class TypewritterState {
  final TypewriterConfigModel config;
  const TypewritterState({this.config = const TypewriterConfigModel()});

  TypewritterState copyWith({TypewriterConfigModel? config}) {
    return TypewritterState(config: config ?? this.config);
  }
}
