import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/animations/crawl/crawl_cubit.dart';
import 'package:led_panel/bloc/animations/marquee/marquee_cubit.dart';
import 'package:led_panel/bloc/animations/scramble/scramble_cubit.dart';
import 'package:led_panel/bloc/animations/typewritter/typewritter_cubit.dart';
import 'package:led_panel/bloc/animations/wave/wave_cubit.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';
import 'package:led_panel/presentation/pages/config_page.dart';

class AuxConfigPage extends StatelessWidget {
  final LedPanelConfigModel? initialConfig;
  const AuxConfigPage({super.key, this.initialConfig});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MarqueeCubit>(create: (context) => MarqueeCubit()),
        BlocProvider<TypewritterCubit>(create: (context) => TypewritterCubit()),
        BlocProvider<WaveCubit>(create: (context) => WaveCubit()),
        BlocProvider<ScrambleCubit>(create: (context) => ScrambleCubit()),
        BlocProvider<CrawlCubit>(create: (context) => CrawlCubit()),
      ],
      child: ConfigPage(initialConfig: initialConfig),
    );
  }
}
