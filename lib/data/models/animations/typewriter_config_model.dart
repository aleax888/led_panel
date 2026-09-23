import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';

class TypewriterConfigModel extends AnimationConfigModel {
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.typewriter;
  final Duration characterDuration;
  final Duration characterDurationNoise;
  final Duration completionPause;

  const TypewriterConfigModel({
    this.characterDuration = const Duration(milliseconds: 80),
    this.characterDurationNoise = const Duration(milliseconds: 400),
    this.completionPause = const Duration(seconds: 1),
  });

  @override
  TypewriterConfigModel copyWith({
    Duration? characterDuration,
    Duration? characterDurationNoise,
    Duration? completionPause,
  }) {
    return TypewriterConfigModel(
      characterDuration: characterDuration ?? this.characterDuration,
      characterDurationNoise:
          characterDurationNoise ?? this.characterDurationNoise,
      completionPause: completionPause ?? this.completionPause,
    );
  }

  @override
  TypewriterConfigModel copyWithProportion(double proportion) {
    return this;
  }

  factory TypewriterConfigModel.fromJson(Map<String, dynamic> json) {
    return TypewriterConfigModel(
      characterDuration: Duration(
        milliseconds: (json['character_duration'] as num?)?.toInt() ?? 80,
      ),
      characterDurationNoise: Duration(
        milliseconds:
            (json['character_duration_noise'] as num?)?.toInt() ?? 400,
      ),
      completionPause: Duration(
        milliseconds: (json['completion_pause'] as num?)?.toInt() ?? 1000,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'character_duration': characterDuration.inMilliseconds,
      'character_duration_noise': characterDurationNoise.inMilliseconds,
      'completion_pause': completionPause.inMilliseconds,
    };
  }
}
