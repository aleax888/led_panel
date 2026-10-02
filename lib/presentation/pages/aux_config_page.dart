import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/configs/animations/crawl/crawl_cubit.dart';
import 'package:led_panel/bloc/configs/animations/marquee/marquee_cubit.dart';
import 'package:led_panel/bloc/configs/animations/scramble/scramble_cubit.dart';
import 'package:led_panel/bloc/configs/animations/typewritter/typewritter_cubit.dart';
import 'package:led_panel/bloc/configs/animations/wave/wave_cubit.dart';
import 'package:led_panel/bloc/configs/backgrounds/image/image_cubit.dart';
import 'package:led_panel/bloc/configs/backgrounds/linear_gradient/linear_gradient_cubit.dart';
import 'package:led_panel/bloc/configs/backgrounds/solid_color/solid_color_cubit.dart';
import 'package:led_panel/bloc/configs/leds/leds_cubit.dart';
import 'package:led_panel/bloc/configs/text/text_cubit.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/crawl_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/marquee_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/scramble_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/typewriter_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/wave_config_model.dart';
import 'package:led_panel/data/models/led_panel/background_configs/image_config_model.dart';
import 'package:led_panel/data/models/led_panel/background_configs/linear_gradient_config_model.dart';
import 'package:led_panel/data/models/led_panel/background_configs/solid_color_config_model.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';
import 'package:led_panel/presentation/pages/config_page.dart';

/// Bloc provider for the auxiliary configuration page, which sets up the necessary state management for text, animations, backgrounds, and LED settings based on an optional initial configuration.
class AuxConfigPage extends StatelessWidget {
  final LedPanelConfigModel? initialConfig;
  const AuxConfigPage({super.key, this.initialConfig});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Text ----------------------------------------------
        BlocProvider<TextCubit>(
          create: (context) => TextCubit(config: initialConfig?.text),
        ),
        // Animations ----------------------------------------------
        BlocProvider<MarqueeCubit>(
          create: (context) => MarqueeCubit(
            config: initialConfig?.animation is MarqueeConfigModel
                ? initialConfig?.animation as MarqueeConfigModel
                : null,
          ),
        ),
        BlocProvider<TypewritterCubit>(
          create: (context) => TypewritterCubit(
            config: initialConfig?.animation is TypewriterConfigModel
                ? initialConfig?.animation as TypewriterConfigModel
                : null,
          ),
        ),
        BlocProvider<WaveCubit>(
          create: (context) => WaveCubit(
            config: initialConfig?.animation is WaveConfigModel
                ? initialConfig?.animation as WaveConfigModel
                : null,
          ),
        ),
        BlocProvider<ScrambleCubit>(
          create: (context) => ScrambleCubit(
            config: initialConfig?.animation is ScrambleConfigModel
                ? initialConfig?.animation as ScrambleConfigModel
                : null,
          ),
        ),
        BlocProvider<CrawlCubit>(
          create: (context) => CrawlCubit(
            config: initialConfig?.animation is CrawlConfigModel
                ? initialConfig?.animation as CrawlConfigModel
                : null,
          ),
        ),
        // Background ----------------------------------------------
        BlocProvider<SolidColorCubit>(
          create: (context) => SolidColorCubit(
            config: initialConfig?.background is SolidColorConfigModel
                ? initialConfig?.background as SolidColorConfigModel
                : null,
          ),
        ),
        BlocProvider<LinearGradientCubit>(
          create: (context) => LinearGradientCubit(
            config: initialConfig?.background is LinearGradientConfigModel
                ? initialConfig?.background as LinearGradientConfigModel
                : null,
          ),
        ),
        BlocProvider<ImageCubit>(
          create: (context) => ImageCubit(
            config: initialConfig?.background is ImageConfigModel
                ? initialConfig?.background as ImageConfigModel
                : null,
          ),
        ),
        // Leds ----------------------------------------------
        BlocProvider<LedsCubit>(
          create: (context) => LedsCubit(config: initialConfig?.leds),
        ),
      ],
      child: ConfigPage(initialConfig: initialConfig),
    );
  }
}
