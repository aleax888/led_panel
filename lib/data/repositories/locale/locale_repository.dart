import 'package:led_panel/data/enums/locale_enum.dart';

abstract class LocaleRepository {
  Future<LocaleEnum?> getLocale();
  Future<void> saveLocale(LocaleEnum themeMode);
}
