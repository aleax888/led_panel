import 'package:led_panel/data/models/animations/crawl_config_model.dart';
import 'package:led_panel/data/models/animations/scramble_config_model.dart';
import 'package:led_panel/data/models/animations/typewriter_config_model.dart';
import 'package:led_panel/data/models/animations/wave_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';
import 'package:led_panel/data/models/animations/marquee_config_model.dart';
import 'package:led_panel/data/models/animations/none_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_filds/animation_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_filds/crawl_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_filds/marquee_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_filds/scramble_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_filds/typewriter_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_filds/wave_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_filds/none_fields.dart';

enum AnimationTypeEnum {
  // No animation, static text
  none(
    label: 'None',
    asset: 'assets/animations/none.gif',
    fromJson: NoneConfigModel.fromJson,
    defaultConfigFactory: NoneConfigModel.new,
    fields: NoneFields(),
  ),
  // Scrolling text from one side to the other
  marquee(
    label: 'Marquee',
    asset: 'assets/animations/marquee.gif',
    fromJson: MarqueeConfigModel.fromJson,
    defaultConfigFactory: MarqueeConfigModel.new,
    fields: MarqueeFields(),
  ),
  // Text appears one character at a time
  typewriter(
    label: 'Typewriter',
    asset: 'assets/animations/typewriter.gif',
    fromJson: TypewriterConfigModel.fromJson,
    defaultConfigFactory: TypewriterConfigModel.new,
    fields: TypewriterFields(),
  ),
  // Text appears in a wave-like motion
  wave(
    label: 'Wave',
    asset: 'assets/animations/wave.gif',
    fromJson: WaveConfigModel.fromJson,
    defaultConfigFactory: WaveConfigModel.new,
    fields: WaveFields(),
  ),
  // Text appears in a scrambled manner before revealing the final message
  scramble(
    label: 'Scramble',
    asset: 'assets/animations/scramble.gif',
    fromJson: ScrambleConfigModel.fromJson,
    defaultConfigFactory: ScrambleConfigModel.new,
    fields: ScrambleFields(),
  ),
  // Text appears to crawl across the screen (STAR WARS style)
  crawl(
    label: 'Crawl',
    asset: 'assets/animations/crawl.gif',
    fromJson: CrawlConfigModel.fromJson,
    defaultConfigFactory: CrawlConfigModel.new,
    fields: CrawlFields(),
  );

  const AnimationTypeEnum({
    required this.label,
    required this.asset,
    required this.fromJson,
    required this.defaultConfigFactory,
    required this.fields,
  });

  final String label;
  final String asset;
  final Function fromJson;
  final AnimationConfigModel Function() defaultConfigFactory;
  final AnimationFields fields;

  AnimationConfigModel get defaultConfig => defaultConfigFactory();
}

// blink — encender/apagar rápidamente.
// fade — aparecer y desaparecer gradualmente.
// pulse — similar a fade, pero más rítmico.
// flash — destellos rápidos.
// bounce — el contenido rebota de un lado a otro.
// shake — pequeño movimiento horizontal/vertical.
// zoom — crecer y reducir el contenido.
