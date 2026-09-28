import 'package:led_panel/data/models/led_panel/animation_configs/crawl_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/scramble_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/typewriter_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/wave_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/marquee_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/none_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_fields/animation_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_fields/crawl_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_fields/marquee_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_fields/scramble_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_fields/typewriter_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_fields/wave_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_fields/none_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/animation_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/crawl_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/marquee_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/none_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/scramble_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/typewritter_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/wave_renderer.dart';

enum AnimationTypeEnum {
  // No animation, static text
  none(
    label: 'None',
    asset: 'assets/animations/none.gif',
    fromJson: NoneConfigModel.fromJson,
    defaultConfigFactory: NoneConfigModel.new,
    fields: NoneFields(),
    renderer: NoneRenderer(),
  ),
  // Scrolling text from one side to the other
  marquee(
    label: 'Marquee',
    asset: 'assets/animations/marquee.gif',
    fromJson: MarqueeConfigModel.fromJson,
    defaultConfigFactory: MarqueeConfigModel.new,
    fields: MarqueeFields(),
    renderer: MarqueeRenderer(),
  ),
  // Text appears one character at a time
  typewriter(
    label: 'Typewriter',
    asset: 'assets/animations/typewriter.gif',
    fromJson: TypewriterConfigModel.fromJson,
    defaultConfigFactory: TypewriterConfigModel.new,
    fields: TypewriterFields(),
    renderer: TypewriterRenderer(),
  ),
  // Text appears in a wave-like motion
  wave(
    label: 'Wave',
    asset: 'assets/animations/wave.gif',
    fromJson: WaveConfigModel.fromJson,
    defaultConfigFactory: WaveConfigModel.new,
    fields: WaveFields(),
    renderer: WaveRenderer(),
  ),
  // Text appears in a scrambled manner before revealing the final message
  scramble(
    label: 'Scramble',
    asset: 'assets/animations/scramble.gif',
    fromJson: ScrambleConfigModel.fromJson,
    defaultConfigFactory: ScrambleConfigModel.new,
    fields: ScrambleFields(),
    renderer: ScrambleRenderer(),
  ),
  // Text appears to crawl across the screen (STAR WARS style)
  crawl(
    label: 'Crawl',
    asset: 'assets/animations/crawl.gif',
    fromJson: CrawlConfigModel.fromJson,
    defaultConfigFactory: CrawlConfigModel.new,
    fields: CrawlFields(),
    renderer: CrawlRenderer(),
  );

  const AnimationTypeEnum({
    required this.label,
    required this.asset,
    required this.fromJson,
    required this.defaultConfigFactory,
    required this.fields,
    required this.renderer,
  });

  final String label;
  final String asset;
  final Function fromJson;
  final AnimationConfigModel Function() defaultConfigFactory;
  final AnimationFields fields;
  final AnimationRenderer renderer;

  AnimationConfigModel get defaultConfig => defaultConfigFactory();
}

// blink — encender/apagar rápidamente.
// fade — aparecer y desaparecer gradualmente.
// pulse — similar a fade, pero más rítmico.
// flash — destellos rápidos.
// bounce — el contenido rebota de un lado a otro.
// shake — pequeño movimiento horizontal/vertical.
// zoom — crecer y reducir el contenido.
