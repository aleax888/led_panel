import 'dart:math' as math;

import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/enums/crawl_direction_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';

class CrawlConfigModel extends AnimationConfigModel {
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.crawl;
  final double perspective;
  final double tilt;
  final double speed;
  final CrawlTextDirectionEnum direction;

  double get tiltDegrees => tilt * (180 / math.pi);

  const CrawlConfigModel({
    this.perspective = 0.0014,
    this.tilt = -0.62,
    this.speed = 80.0,
    this.direction = .toTop,
  });

  @override
  CrawlConfigModel copyWith({
    double? perspective,
    double? tilt,
    double? speed,
    CrawlTextDirectionEnum? direction,
  }) {
    return CrawlConfigModel(
      perspective: perspective ?? this.perspective,
      tilt: tilt ?? this.tilt,
      speed: speed ?? this.speed,
      direction: direction ?? this.direction,
    );
  }

  @override
  CrawlConfigModel copyWithProportion(double proportion) {
    return copyWith(speed: speed * proportion);
  }

  CrawlConfigModel copyWithPreservedDepth({required double tilt}) {
    const minTilt = 0.001;

    if (tilt.abs() < minTilt) {
      return copyWith(tilt: tilt);
    }

    final oldSin = math.sin(this.tilt).abs();
    final newSin = math.sin(tilt).abs();

    final newPerspective = perspective * oldSin / newSin;

    return copyWith(tilt: tilt, perspective: newPerspective);
  }

  factory CrawlConfigModel.fromJson(Map<String, dynamic> json) {
    return CrawlConfigModel(
      perspective: (json['perspective'] as num?)?.toDouble() ?? 0.0014,
      tilt: (json['tilt'] as num?)?.toDouble() ?? -0.62,
      speed: (json['speed'] as num?)?.toDouble() ?? 80.0,
      direction: CrawlTextDirectionEnum.values.firstWhere(
        (e) => e.label == json['direction'],
        orElse: () => .toTop,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'perspective': perspective,
      'tilt': tilt,
      'speed': speed,
      'direction': direction.label,
    };
  }
}
