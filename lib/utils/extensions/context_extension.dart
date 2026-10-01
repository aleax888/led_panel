import 'package:flutter/material.dart';
import 'package:led_panel/l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
  Size get screenSize => MediaQuery.sizeOf(this);
  AppLocalizations get locale => AppLocalizations.of(this)!;
}
