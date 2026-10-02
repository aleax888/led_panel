import 'package:flutter/material.dart';

/// Abstract class representing a repository for managing theme settings.
abstract class ThemeRepository {
  Future<ThemeMode?> getThemeMode();
  Future<void> saveThemeMode(ThemeMode themeMode);
}
