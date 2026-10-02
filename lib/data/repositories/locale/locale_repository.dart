import 'package:led_panel/data/enums/locale_enum.dart';

/// Abstract class representing a repository for managing locale settings.
abstract class LocaleRepository {
  Future<LocaleEnum?> getLocale();
  Future<void> saveLocale(LocaleEnum themeMode);
}
