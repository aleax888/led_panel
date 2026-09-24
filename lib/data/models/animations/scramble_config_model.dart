import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';

class ScrambleConfigModel extends AnimationConfigModel {
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.scramble;
  final Duration characterDuration;
  final Duration completionPause;
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
