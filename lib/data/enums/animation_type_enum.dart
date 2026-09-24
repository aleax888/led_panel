import 'package:led_panel/data/models/animations/crawl_config_model.dart';
import 'package:led_panel/data/models/animations/scramble_config_model.dart';
import 'package:led_panel/data/models/animations/typewriter_config_model.dart';
import 'package:led_panel/data/models/animations/wave_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';
import 'package:led_panel/data/models/animations/marquee_config_model.dart';
import 'package:led_panel/data/models/animations/none_config_model.dart';

enum AnimationTypeEnum {
  // No animation, static text
  none(
    label: 'None',
    asset: 'assets/animations/none.gif',
    fromJson: NoneConfigModel.fromJson,
    defaultConfigFactory: NoneConfigModel.new,
  ),
  // Scrolling text from one side to the other
  marquee(
    label: 'Marquee',
    asset: 'assets/animations/marquee.gif',
    fromJson: MarqueeConfigModel.fromJson,
    defaultConfigFactory: MarqueeConfigModel.new,
  ),
  // Text appears one character at a time
  typewriter(
    label: 'Typewriter',
    asset: 'assets/animations/typewriter.gif',
    fromJson: TypewriterConfigModel.fromJson,
    defaultConfigFactory: TypewriterConfigModel.new,
  ),
  // Text appears in a wave-like motion
  wave(
    label: 'Wave',
    asset: 'assets/animations/wave.gif',
    fromJson: WaveConfigModel.fromJson,
    defaultConfigFactory: WaveConfigModel.new,
  ),
  // Text appears in a scrambled manner before revealing the final message
  scramble(
    label: 'Scramble',
    asset: 'assets/animations/scramble.gif',
    fromJson: ScrambleConfigModel.fromJson,
    defaultConfigFactory: ScrambleConfigModel.new,
  ),
  // Text appears to crawl across the screen (STAR WARS style)
  crawl(
    label: 'Crawl',
    asset: 'assets/animations/crawl.gif',
    fromJson: CrawlConfigModel.fromJson,
    defaultConfigFactory: CrawlConfigModel.new,
  );

  const AnimationTypeEnum({
    required this.label,
    required this.asset,
    required this.fromJson,
    required this.defaultConfigFactory,
  });

  final String label;
  final String asset;
  final Function fromJson;
  final AnimationConfigModel Function() defaultConfigFactory;

  AnimationConfigModel get defaultConfig => defaultConfigFactory();
}

// blink — encender/apagar rápidamente.
// fade — aparecer y desaparecer gradualmente.
// pulse — similar a fade, pero más rítmico.
// flash — destellos rápidos.
// bounce — el contenido rebota de un lado a otro.
// shake — pequeño movimiento horizontal/vertical.
// zoom — crecer y reducir el contenido.
