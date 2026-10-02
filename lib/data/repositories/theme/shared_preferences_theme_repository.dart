import 'package:flutter/material.dart';
import 'package:led_panel/data/repositories/theme/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of [ThemeRepository] that uses SharedPreferences for data persistence.
class SharedPrefsThemeRepository implements ThemeRepository {
  static const String _key = 'theme_mode';

  @override
  Future<ThemeMode?> getThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString(_key);

    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => null,
    };
  }

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, themeMode.name);
  }
}
