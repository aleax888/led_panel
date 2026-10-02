import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';

/// Model class representing the configuration for a "none" animation, which indicates no animation.
class NoneConfigModel extends AnimationConfigModel {
  /// The type of animation, which is set to [AnimationTypeEnum.none].
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.none;
  const NoneConfigModel();

  @override
  NoneConfigModel copyWith() {
    return NoneConfigModel();
  }

  @override
  NoneConfigModel copyWithProportion(double proportion) {
    return this;
  }

  factory NoneConfigModel.fromJson(Map<String, dynamic> json) {
    return NoneConfigModel();
  }

  @override
  Map<String, dynamic> toJson() {
    return {'type': type.name};
  }
}
