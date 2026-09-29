import 'package:led_panel/data/enums/background_type_enum.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';

class ImageConfigModel implements BackgroundConfigModel {
  @override
  final BackgroundTypeEnum type = BackgroundTypeEnum.image;
  final String? url;

  const ImageConfigModel({this.url});

  @override
  ImageConfigModel copyWith({String? url}) {
    return ImageConfigModel(url: url ?? this.url);
  }

  factory ImageConfigModel.fromJson(Map<String, dynamic> json) {
    return ImageConfigModel(url: json['url'] as String?);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'type': type.name, 'url': url};
  }
}
