import 'dart:ui';

import 'package:led_panel/data/enums/locale_enum.dart';
import 'package:led_panel/data/repositories/locale/locale_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of [LocaleRepository] that uses SharedPreferences for data persistence.
class SharedPrefsLocaleRepository implements LocaleRepository {
  static const String _key = 'locale';

  @override
  Future<LocaleEnum?> getLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString(_key);

    return LocaleEnum.values.firstWhere(
      (e) => e.name == value,
      orElse: () {
        final String deviceLanguage =
            PlatformDispatcher.instance.locale.languageCode;

        return LocaleEnum.values.firstWhere(
          (e) => e.name == deviceLanguage,
          orElse: () => LocaleEnum.en,
        );
      },
    );
  }

  @override
  Future<void> saveLocale(LocaleEnum locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.name);
  }
}
