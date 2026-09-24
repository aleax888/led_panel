import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/enums/marquee_direction_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';

class MarqueeConfigModel extends AnimationConfigModel {
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.marquee;
  final double speed;
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
