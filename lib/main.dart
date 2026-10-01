import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:led_panel/bloc/locale/locale_cubit.dart';
import 'package:led_panel/data/enums/locale_enum.dart';
import 'l10n/app_localizations.dart';
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

class LedPanelApp extends StatefulWidget {
  const LedPanelApp({super.key});

  @override
  State<LedPanelApp> createState() => _LedPanelAppState();
}

class _LedPanelAppState extends State<LedPanelApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LedPanelBloc>(create: (context) => LedPanelBloc()),
        BlocProvider<LedPanelListBloc>(create: (context) => LedPanelListBloc()),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<LocaleCubit>(create: (context) => LocaleCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'LED Panel',
                locale: state.locale.locale,
                supportedLocales: LocaleEnum.values.map((e) => e.locale),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeState.themeMode,
                navigatorKey: GlobalContext.navigatorKey,
                debugShowCheckedModeBanner: kDebugMode,
                home: Builder(
                  builder: (context) {
                    GlobalContext.globalContext = context;
                    return const HomePage();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
