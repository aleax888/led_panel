import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/utils/angle_handler.dart';

/// Model class representing the configuration for a wave animation.
class WaveConfigModel extends AnimationConfigModel {
  /// The type of animation, which is set to [AnimationTypeEnum.wave].
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.wave;
  /// The amplitude of the wave animation, affecting the height of the wave.
  final double amplitude;
  /// The frequency of the wave animation, affecting how many waves are displayed.
  final double frequency;
  /// The phase step of the wave animation, affecting the speed of the wave's movement.
  final double phaseStep;
  
  /// Returns the phase step in degrees, which is useful for understanding the wave's movement in a more intuitive unit.
  double get phaseStepDegrees => AngleHandler.radiansToDegrees(phaseStep);

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
