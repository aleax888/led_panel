import 'package:flutter/material.dart';
import 'package:led_panel/data/enums/background_type_enum.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';

class SolidColorConfigModel implements BackgroundConfigModel {
  @override
  final BackgroundTypeEnum type = BackgroundTypeEnum.solidColor;
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
