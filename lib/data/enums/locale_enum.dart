import 'dart:ui';

/// Enum representing the supported locales for the application.
enum LocaleEnum {
  /// Spanish locale
  es(locale: Locale('es'), label: 'Español'),

  /// English locale
  en(locale: Locale('en'), label: 'English');

  const LocaleEnum({required this.locale, required this.label});

  /// The [Locale] object representing the locale.
  final Locale locale;
  /// The human-readable label for the locale, used in the UI.
  final String label;
}
