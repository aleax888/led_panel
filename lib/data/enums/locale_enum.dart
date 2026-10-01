import 'dart:ui';

enum LocaleEnum {
  es(locale: Locale('es')),
  en(locale: Locale('en'));

  const LocaleEnum({required this.locale});

  final Locale locale;
}
