import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/home_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/led_panel_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
        debugShowCheckedModeBanner: kDebugMode,
        home: const HomePage(),
      ),
    );
  }
}
