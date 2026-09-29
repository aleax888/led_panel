import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/enums/background_type_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/leds_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/marquee_config_model.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';
import 'package:led_panel/data/models/led_panel/background_configs/solid_color_config_model.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';

class LedPanelConfigModel {
  // Metadata
  final String? id;
  final DateTime? createdAt;
  final bool favorite;
  // Text Style
  final TextConfigModel text;
  // Animation
  final AnimationConfigModel animation;
  // Background
  final BackgroundConfigModel background;
  // Leds
  final LedsConfigModel leds;

  const LedPanelConfigModel({
    // Metadata
    this.id,
    this.createdAt,
    this.favorite = false,
    // Text Style
    this.text = const TextConfigModel(),
    // Animation
    this.animation = const MarqueeConfigModel(),
    // Background
    this.background = const SolidColorConfigModel(),
    // Leds
    this.leds = const LedsConfigModel(),
  });

  LedPanelConfigModel copyWith({
    // Metadata
    String? id,
    DateTime? createdAt,
    bool? favorite,
    // Text Style
    TextConfigModel? text,
    // Animation
    AnimationConfigModel? animation,
    // Background
    BackgroundConfigModel? background,
    // Leds
    LedsConfigModel? leds,
  }) {
    return LedPanelConfigModel(
      // Metadata
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      favorite: favorite ?? this.favorite,
      // Text Style
      text: text ?? this.text,
      // Animation
      animation: animation ?? this.animation,
      // Background
      background: background ?? this.background,
      // Leds
      leds: leds ?? this.leds,
    );
  }

  LedPanelConfigModel copyWithProportion(double proportion) {
    return copyWith(
      text: text.copyWithProportion(proportion),
      animation: animation.copyWithProportion(proportion),
    );
  }

  factory LedPanelConfigModel.fromJson(Map<String, dynamic> json) {
    final AnimationTypeEnum? animationType = json['animation']?['type'] == null
        ? null
        : [...AnimationTypeEnum.values, null].firstWhere(
            (e) => e?.name == json['animation']?['type'],
            orElse: () => null,
          );
    final BackgroundTypeEnum? backgroundType =
        json['background']?['type'] == null
        ? null
        : [...BackgroundTypeEnum.values, null].firstWhere(
            (e) => e?.name == json['background']?['type'],
            orElse: () => null,
          );

    return LedPanelConfigModel(
      // Metadata
      id: json['id'],
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      favorite: json['favorite'] ?? false,
      // Text Style
      text: TextConfigModel.fromJson(json['text']),
      // Animation
      animation: animationType == null
          ? const MarqueeConfigModel()
          : animationType.fromJson(json['animation']),
      // Background
      background: backgroundType == null
          ? const SolidColorConfigModel()
          : backgroundType.fromJson(json['background']),
      // Leds
      leds: LedsConfigModel.fromJson(json['leds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // Metadata
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'favorite': favorite,
      // Text Style
      'text': text.toJson(),
      // Animation
      'animation': animation.toJson(),
      // Background
      'background': background.toJson(),
      // Leds
      'leds': leds.toJson(),
    };
  }
}
