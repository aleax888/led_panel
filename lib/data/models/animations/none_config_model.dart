import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/models/animations/animation_config_model.dart';

class NoneAnimationModel extends AnimationConfigModel {
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.none;
  const NoneAnimationModel();

  @override
  NoneAnimationModel copyWith() {
    return NoneAnimationModel();
  }

  @override
  NoneAnimationModel copyWithProportion(double proportion) {
    return copyWith();
  }

  factory NoneAnimationModel.fromJson(Map<String, dynamic> json) {
    return NoneAnimationModel();
  }

  @override
  Map<String, dynamic> toJson() {
    return {'type': type.name};
  }
}
