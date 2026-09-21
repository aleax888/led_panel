import 'package:led_panel/data/enums/animation_type_enum.dart';

abstract class AnimationConfigModel {
  AnimationTypeEnum get type;
  const AnimationConfigModel();

  AnimationConfigModel copyWith();
  AnimationConfigModel copyWithProportion(double proportion);
  Map<String, dynamic> toJson();
}
