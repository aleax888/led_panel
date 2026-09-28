import 'package:flutter/material.dart';

class BackgroundConfigModel {
  final Color color;
  final String? imageUrl;

  const BackgroundConfigModel({this.color = Colors.black, this.imageUrl});

  BackgroundConfigModel copyWith({Color? color, String? imageUrl}) {
    return BackgroundConfigModel(
      color: color ?? this.color,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  BackgroundConfigModel copyWithProportion(double proportion) {
    return copyWith();
  }

  factory BackgroundConfigModel.fromJson(Map<String, dynamic> json) {
    return BackgroundConfigModel(
      color: json['color'] != null ? Color(json['color'] as int) : Colors.black,
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'color': color.toARGB32(), 'image_url': imageUrl};
  }
}
