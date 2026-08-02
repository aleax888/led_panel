import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:led_panel/theme/app_theme.dart';

import 'presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/led_panel_bloc.dart';

void main() {
  runApp(const LedPanelApp());
}

class LedPanelApp extends StatelessWidget {
  const LedPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LedPanelBloc(),
      child: MaterialApp(
        title: 'LED Panel',
        theme: AppTheme.light,
        debugShowCheckedModeBanner: kDebugMode,
        home: const HomePage(),
      ),
    );
  }
}
