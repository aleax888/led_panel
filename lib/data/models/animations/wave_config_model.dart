import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';

class WaveConfigModel extends AnimationConfigModel {
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.wave;
  final double amplitude;
  final double frequency;
  final double phaseStep;

  const WaveConfigModel({
    this.amplitude = 18.0,
    this.frequency = 4.0,
    this.phaseStep = 0.65,
  });

  @override
  WaveConfigModel copyWith({
    double? amplitude,
    double? frequency,
    double? phaseStep,
  }) {
    return WaveConfigModel(
      amplitude: amplitude ?? this.amplitude,
      frequency: frequency ?? this.frequency,
      phaseStep: phaseStep ?? this.phaseStep,
    );
  }

  @override
  WaveConfigModel copyWithProportion(double proportion) {
    return copyWith(amplitude: amplitude * proportion);
  }

  factory WaveConfigModel.fromJson(Map<String, dynamic> json) {
    return WaveConfigModel(
      amplitude: (json['amplitude'] as num?)?.toDouble() ?? 18.0,
      frequency: (json['frequency'] as num?)?.toDouble() ?? 4.0,
      phaseStep: (json['phase_step'] as num?)?.toDouble() ?? 0.65,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'amplitude': amplitude,
      'frequency': frequency,
      'phase_step': phaseStep,
    };
  }
}
