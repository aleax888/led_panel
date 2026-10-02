import 'package:led_panel/data/enums/animation_type_enum.dart';

/// Abstract class representing the configuration for an animation.
abstract class AnimationConfigModel {
  AnimationTypeEnum get type;
  const AnimationConfigModel();

  AnimationConfigModel copyWith();
  /// Returns a new instance of the animation configuration with properties scaled by the given [proportion].
  AnimationConfigModel copyWithProportion(double proportion);
  Map<String, dynamic> toJson();
}
