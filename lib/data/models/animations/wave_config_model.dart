import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';

class WaveConfigModel extends AnimationConfigModel {
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.wave;
  const WaveConfigModel();

  @override
  WaveConfigModel copyWith() {
    return WaveConfigModel();
  }

  @override
  WaveConfigModel copyWithProportion(double proportion) {
    return copyWith();
  }

  factory WaveConfigModel.fromJson(Map<String, dynamic> json) {
    return WaveConfigModel();
  }

  @override
  Map<String, dynamic> toJson() {
    return {'type': type.name};
  }
}
