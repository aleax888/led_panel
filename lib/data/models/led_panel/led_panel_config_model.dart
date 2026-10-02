import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/enums/background_type_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/leds_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/marquee_config_model.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';
import 'package:led_panel/data/models/led_panel/background_configs/solid_color_config_model.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';

/// Model class representing the configuration for an LED panel, including metadata, text style, animation, background, and LED settings.
class LedPanelConfigModel {
  /// The unique identifier for the LED panel configuration.
  final String? id;
  /// The creation date and time of the LED panel configuration.
  final DateTime? createdAt;
  /// Indicates whether the LED panel configuration is marked as a favorite.
  final bool favorite;
  /// The text configuration for the LED panel, including font, size, and color.
  final TextConfigModel text;
  /// The animation configuration for the LED panel, including type and specific settings.
  final AnimationConfigModel animation;
  /// The background configuration for the LED panel, including type and specific settings.
  final BackgroundConfigModel background;
  /// The LED configuration for the LED panel, including settings for individual LEDs.
  final LedsConfigModel leds;

  const LedPanelConfigModel({
    this.id,
    this.createdAt,
    this.favorite = false,
    this.text = const TextConfigModel(),
    this.animation = const MarqueeConfigModel(),
    this.background = const SolidColorConfigModel(),
    this.leds = const LedsConfigModel(),
  });

  LedPanelConfigModel copyWith({
    String? id,
    DateTime? createdAt,
    bool? favorite,
    TextConfigModel? text,
    AnimationConfigModel? animation,
    BackgroundConfigModel? background,
    LedsConfigModel? leds,
  }) {
    return LedPanelConfigModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      favorite: favorite ?? this.favorite,
      text: text ?? this.text,
      animation: animation ?? this.animation,
      background: background ?? this.background,
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
