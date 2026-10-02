import 'package:led_panel/data/enums/background_type_enum.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';

/// Model class representing the configuration for an image background.
class ImageConfigModel implements BackgroundConfigModel {
  /// The type of background, which is set to [BackgroundTypeEnum.image].
  @override
  final BackgroundTypeEnum type = BackgroundTypeEnum.image;
  /// The URL of the image to be used as the background.
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
