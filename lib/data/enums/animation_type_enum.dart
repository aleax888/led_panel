import 'package:led_panel/data/models/led_panel/animation_config_model.dart';
import 'package:led_panel/data/models/animations/marquee_config_model.dart';
import 'package:led_panel/data/models/animations/none_config_model.dart';

enum AnimationTypeEnum { none, marquee }

extension AnimationTypeExtension on AnimationTypeEnum {
  /// Human-readable name shown in the interface.
  String get label {
    switch (this) {
      case .none:
        return 'None';
      case .marquee:
        return 'Marquee';
    }
  }

  /// Path to the corresponding animation asset.
  String get asset {
    switch (this) {
      case .none:
        return 'assets/animations/none.gif';
      case .marquee:
        return 'assets/animations/marquee.gif';
    }
  }

  /// Function to create an instance of the corresponding animation model from JSON.
  Function get fromJson {
    switch (this) {
      case .none:
        return NoneAnimationModel.fromJson;
      case .marquee:
        return MarqueeConfigModel.fromJson;
    }
  }

  /// Returns the default configuration for the corresponding animation type.
  AnimationConfigModel get defaultConfig {
    switch (this) {
      case .none:
        return const NoneAnimationModel();
      case .marquee:
        return const MarqueeConfigModel();
    }
  }
}
