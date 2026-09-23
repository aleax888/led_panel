import 'package:led_panel/data/models/animations/crawl_config_model.dart';
import 'package:led_panel/data/models/animations/scramble_config_model.dart';
import 'package:led_panel/data/models/animations/typewriter_config_model.dart';
import 'package:led_panel/data/models/animations/wave_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';
import 'package:led_panel/data/models/animations/marquee_config_model.dart';
import 'package:led_panel/data/models/animations/none_config_model.dart';

enum AnimationTypeEnum {
  none, // No animation, static text
  marquee, // Scrolling text from one side to the other
  typewriter, // Text appears one character at a time
  wave, // Text appears in a wave-like motion
  scramble, // Text appears in a scrambled manner before revealing the final message
  crawl, // Text appears to crawl across the screen (STAR WARS style)
}

// blink — encender/apagar rápidamente.
// fade — aparecer y desaparecer gradualmente.
// pulse — similar a fade, pero más rítmico.
// flash — destellos rápidos.
// bounce — el contenido rebota de un lado a otro.
// shake — pequeño movimiento horizontal/vertical.
// zoom — crecer y reducir el contenido.

extension AnimationTypeExtension on AnimationTypeEnum {
  /// Human-readable name shown in the interface.
  String get label {
    switch (this) {
      case .none:
        return 'None';
      case .marquee:
        return 'Marquee';
      case .typewriter:
        return 'Typewriter';
      case .wave:
        return 'Wave';
      case .scramble:
        return 'Scramble';
      case .crawl:
        return 'Crawl';
    }
  }

  /// Path to the corresponding animation asset.
  String get asset {
    switch (this) {
      case .none:
        return 'assets/animations/none.gif';
      case .marquee:
        return 'assets/animations/marquee.gif';
      case .typewriter:
        return 'assets/animations/typewriter.gif';
      case .wave:
        return 'assets/animations/wave.gif';
      case .scramble:
        return 'assets/animations/scramble.gif';
      case .crawl:
        return 'assets/animations/crawl.gif';
    }
  }

  /// Function to create an instance of the corresponding animation model from JSON.
  Function get fromJson {
    switch (this) {
      case .none:
        return NoneConfigModel.fromJson;
      case .marquee:
        return MarqueeConfigModel.fromJson;
      case .typewriter:
        return TypewriterConfigModel.fromJson;
      case .wave:
        return WaveConfigModel.fromJson;
      case .scramble:
        return ScrambleConfigModel.fromJson;
      case .crawl:
        return CrawlConfigModel.fromJson;
    }
  }

  /// Returns the default configuration for the corresponding animation type.
  AnimationConfigModel get defaultConfig {
    switch (this) {
      case .none:
        return const NoneConfigModel();
      case .marquee:
        return const MarqueeConfigModel();
      case .typewriter:
        return const TypewriterConfigModel();
      case .wave:
        return const WaveConfigModel();
      case .scramble:
        return const ScrambleConfigModel();
      case .crawl:
        return const CrawlConfigModel();
    }
  }
}
