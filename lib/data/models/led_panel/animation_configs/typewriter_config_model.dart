import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';

/// Model class representing the configuration for a typewriter animation.
class TypewriterConfigModel extends AnimationConfigModel {
  /// The type of animation, which is set to [AnimationTypeEnum.typewriter].
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.typewriter;
  /// The duration for each character in the typewriter animation, affecting how long each character is displayed.
  final Duration characterDuration;
  /// The additional random duration added to each character's display time, creating a more natural typing effect.
  final Duration characterDurationNoise;
  /// The duration to pause after the typewriter animation is complete.
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
