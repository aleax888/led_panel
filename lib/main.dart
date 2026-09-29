import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart' as intl_local_data;

import 'package:led_panel/theme/app_theme.dart';
import 'package:led_panel/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel_list/led_panel_list_bloc.dart';
import 'package:led_panel/bloc/led_panel/led_panel_bloc.dart';
import 'package:led_panel/bloc/theme/theme_cubit.dart';
import 'package:led_panel/utils/global_context.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  intl_local_data.initializeDateFormatting();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'LED Panel',
            navigatorKey: GlobalContext.navigatorKey,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            debugShowCheckedModeBanner: kDebugMode,
            home: Builder(
              builder: (context) {
                GlobalContext.globalContext = context;
                return const HomePage();
              },
            ),
          );
        },
      ),
    );
  }
}
