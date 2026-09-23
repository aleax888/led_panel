import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';

class CrawlConfigModel extends AnimationConfigModel {
  @override
  final AnimationTypeEnum type = AnimationTypeEnum.crawl;
  const CrawlConfigModel();

  @override
  CrawlConfigModel copyWith() {
    return CrawlConfigModel();
  }

  @override
  CrawlConfigModel copyWithProportion(double proportion) {
    return copyWith();
  }

  factory CrawlConfigModel.fromJson(Map<String, dynamic> json) {
    return CrawlConfigModel();
  }

  @override
  Map<String, dynamic> toJson() {
    return {'type': type.name};
  }
}
