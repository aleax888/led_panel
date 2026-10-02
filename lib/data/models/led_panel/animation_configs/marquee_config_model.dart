import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/enums/marquee_direction_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';

/// Model class representing the configuration for a marquee animation.
class MarqueeConfigModel extends AnimationConfigModel {
  /// The type of animation, which is set to [AnimationTypeEnum.marquee].
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.marquee;
  /// The speed of the marquee animation, affecting how fast the text moves.
  final double speed;
  /// The direction in which the text scrolls, represented by [MarqueeDirectionEnum].
  final MarqueeDirectionEnum direction;

  const MarqueeConfigModel({this.speed = 80.0, this.direction = .toLeft});

  @override
  MarqueeConfigModel copyWith({
    double? speed,
    MarqueeDirectionEnum? direction,
  }) {
    return MarqueeConfigModel(
      speed: speed ?? this.speed,
      direction: direction ?? this.direction,
    );
  }

  @override
  MarqueeConfigModel copyWithProportion(double proportion) {
    return copyWith(speed: speed * proportion);
  }

  factory MarqueeConfigModel.fromJson(Map<String, dynamic> json) {
    return MarqueeConfigModel(
      speed: (json['speed'] as num?)?.toDouble() ?? 80.0,
      direction: MarqueeDirectionEnum.values.firstWhere(
        (e) => e.label == json['direction'],
        orElse: () => .toLeft,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'type': type.name, 'speed': speed, 'direction': direction.label};
  }
}
