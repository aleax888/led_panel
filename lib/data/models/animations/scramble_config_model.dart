import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';

class ScrambleConfigModel extends AnimationConfigModel {
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.scramble;
  const ScrambleConfigModel();

  @override
  ScrambleConfigModel copyWith() {
    return ScrambleConfigModel();
  }

  @override
  ScrambleConfigModel copyWithProportion(double proportion) {
    return copyWith();
  }

  factory ScrambleConfigModel.fromJson(Map<String, dynamic> json) {
    return ScrambleConfigModel();
  }

  @override
  Map<String, dynamic> toJson() {
    return {'type': type.name};
  }
}
