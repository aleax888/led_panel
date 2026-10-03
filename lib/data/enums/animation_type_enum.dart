import 'package:led_panel/data/models/led_panel/animation_configs/crawl_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/scramble_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/typewriter_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/wave_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/marquee_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/none_config_model.dart';
import 'package:led_panel/presentation/widgets/fields/animation_fields/animation_fields.dart';
import 'package:led_panel/presentation/widgets/fields/animation_fields/crawl_fields.dart';
import 'package:led_panel/presentation/widgets/fields/animation_fields/marquee_fields.dart';
import 'package:led_panel/presentation/widgets/fields/animation_fields/scramble_fields.dart';
import 'package:led_panel/presentation/widgets/fields/animation_fields/typewriter_fields.dart';
import 'package:led_panel/presentation/widgets/fields/animation_fields/wave_fields.dart';
import 'package:led_panel/presentation/widgets/fields/animation_fields/none_fields.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/animation_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/crawl_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/marquee_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/none_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/scramble_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/typewritter_renderer.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_renderers/wave_renderer.dart';

/// Enum representing different types of images/animation_icons for text.
enum AnimationTypeEnum {
  /// No animation, static text
  none(
    label: 'None',
    asset: 'assets/images/animation_icons/none.png',
    fromJson: NoneConfigModel.fromJson,
    defaultConfigFactory: NoneConfigModel.new,
    fields: NoneFields(),
    renderer: NoneRenderer(),
  ),

  /// Scrolling text from one side to the other
  marquee(
    label: 'Marquee',
    asset: 'assets/images/animation_icons/marquee.png',
    fromJson: MarqueeConfigModel.fromJson,
    defaultConfigFactory: MarqueeConfigModel.new,
    fields: MarqueeFields(),
    renderer: MarqueeRenderer(),
  ),

  /// Text appears one character at a time
  typewriter(
    label: 'Typewriter',
    asset: 'assets/images/animation_icons/typewriter.png',
    fromJson: TypewriterConfigModel.fromJson,
    defaultConfigFactory: TypewriterConfigModel.new,
    fields: TypewriterFields(),
    renderer: TypewriterRenderer(),
  ),

  /// Text appears in a wave-like motion
  wave(
    label: 'Wave',
    asset: 'assets/images/animation_icons/wave.png',
    fromJson: WaveConfigModel.fromJson,
    defaultConfigFactory: WaveConfigModel.new,
    fields: WaveFields(),
    renderer: WaveRenderer(),
  ),

  /// Text appears in a scrambled manner before revealing the final message
  scramble(
    label: 'Scramble',
    asset: 'assets/images/animation_icons/scramble.png',
    fromJson: ScrambleConfigModel.fromJson,
    defaultConfigFactory: ScrambleConfigModel.new,
    fields: ScrambleFields(),
    renderer: ScrambleRenderer(),
  ),

  /// Text appears to crawl across the screen (STAR WARS style)
  crawl(
    label: 'Crawl',
    asset: 'assets/images/animation_icons/crawl.png',
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

  /// The human-readable label for the animation type.
  final String label;
  /// The path to the asset representing the animation type.
  final String asset;
  /// A function to deserialize the animation configuration from JSON.
  final Function fromJson;
  /// A factory function to create a default configuration for the animation type.
  final AnimationConfigModel Function() defaultConfigFactory;
  /// The fields widget associated with the animation type, used for user input.
  final AnimationFields fields;
  /// The renderer widget associated with the animation type, used to display the animation.
  final AnimationRenderer renderer;

  AnimationConfigModel get defaultConfig => defaultConfigFactory();
}
