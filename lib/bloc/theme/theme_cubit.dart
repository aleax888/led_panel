import 'package:flutter/material.dart';
import 'package:led_panel/data/repositories/theme/theme_repository.dart';
import 'package:led_panel/data/repositories/theme/shared_preferences_theme_repository.dart';

import 'package:bloc/bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState()) {
    _loadThemeMode();
  }

  final ThemeRepository _repository = SharedPrefsThemeRepository();

  Future<void> _loadThemeMode() async {
    final ThemeMode? themeMode = await _repository.getThemeMode();
    if (themeMode != null) {
      emit(ThemeState(themeMode: themeMode));
    }
  }

  Future<void> switchThemeMode() async {
    final ThemeMode themeMode = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    emit(ThemeState(themeMode: themeMode));
    await _repository.saveThemeMode(themeMode);
  }
}
