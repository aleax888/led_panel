import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:led_panel/bloc/led_panel_list/led_panel_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/led_panel/led_panel_bloc.dart';
import 'package:led_panel/presentation/pages/home_page.dart';
import 'package:led_panel/theme/app_theme.dart';

void main() {
  runApp(const LedPanelApp());
}

class LedPanelApp extends StatelessWidget {
  const LedPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LedPanelBloc>(create: (context) => LedPanelBloc()),
        BlocProvider<LedPanelListBloc>(create: (context) => LedPanelListBloc()),
      ],
      child: MaterialApp(
        title: 'LED Panel',
        theme: AppTheme.light,
        debugShowCheckedModeBanner: kDebugMode,
        home: const HomePage(),
      ),
    );
  }
}
