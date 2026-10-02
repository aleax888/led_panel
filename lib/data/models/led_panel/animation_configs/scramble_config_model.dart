import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';

/// Model class representing the configuration for a scramble animation.
class ScrambleConfigModel extends AnimationConfigModel {
  /// The type of animation, which is set to [AnimationTypeEnum.scramble].
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.scramble;
  /// The duration for each character in the scramble animation, affecting how long each character is displayed.
  final Duration characterDuration;
  /// The duration to pause after the scramble animation is complete.
  final Duration completionPause;
  /// The set of characters to use in the scramble animation.
  final String scrambleCharacters;

  const ScrambleConfigModel({
    this.characterDuration = const Duration(milliseconds: 80),
    this.completionPause = const Duration(seconds: 1),
    this.scrambleCharacters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#%&*+-=?',
  });

  @override
  ScrambleConfigModel copyWith({
    Duration? characterDuration,
    Duration? completionPause,
    String? scrambleCharacters,
  }) {
    return ScrambleConfigModel(
      characterDuration: characterDuration ?? this.characterDuration,
      completionPause: completionPause ?? this.completionPause,
      scrambleCharacters: scrambleCharacters ?? this.scrambleCharacters,
    );
  }

  @override
  ScrambleConfigModel copyWithProportion(double proportion) {
    return copyWith();
  }

  factory ScrambleConfigModel.fromJson(Map<String, dynamic> json) {
    return ScrambleConfigModel(
      characterDuration: Duration(
        milliseconds: (json['character_duration'] as num?)?.toInt() ?? 80,
      ),
      completionPause: Duration(
        milliseconds: (json['completion_pause'] as num?)?.toInt() ?? 1000,
      ),
      scrambleCharacters: json['scramble_characters'] as String? ??
          'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#%&*+-=?',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'character_duration': characterDuration.inMilliseconds,
      'completion_pause': completionPause.inMilliseconds,
      'scramble_characters': scrambleCharacters,
    };
  }
}
