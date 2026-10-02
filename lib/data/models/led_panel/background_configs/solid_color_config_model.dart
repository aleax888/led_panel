import 'package:flutter/material.dart';
import 'package:led_panel/data/enums/background_type_enum.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';

/// Model class representing the configuration for a solid color background.
class SolidColorConfigModel implements BackgroundConfigModel {
  /// The type of background, which is set to [BackgroundTypeEnum.solidColor].
  @override
  final BackgroundTypeEnum type = BackgroundTypeEnum.solidColor;
  /// The color used for the solid color background.
  final Color color;
  
  const SolidColorConfigModel({this.color = Colors.black});

  @override
  SolidColorConfigModel copyWith({Color? color}) {
    return SolidColorConfigModel(color: color ?? this.color);
  }

  factory SolidColorConfigModel.fromJson(Map<String, dynamic> json) {
    return SolidColorConfigModel(
      color: json['color'] != null ? Color(json['color'] as int) : Colors.black,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'type': type.name, 'color': color.toARGB32()};
  }
}
