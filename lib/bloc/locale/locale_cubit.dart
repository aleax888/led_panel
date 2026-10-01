import 'package:led_panel/data/enums/locale_enum.dart';
import 'package:led_panel/data/repositories/locale/locale_repository.dart';
import 'package:led_panel/data/repositories/locale/shared_preferences_locale_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState()) {
    _loadLocaleMode();
  }

  final LocaleRepository _repository = SharedPrefsLocaleRepository();

  Future<void> _loadLocaleMode() async {
    final LocaleEnum? locale = await _repository.getLocale();
    if (locale != null) {
      emit(LocaleState(locale: locale));
    }
  }

  Future<void> changeLocaleMode(LocaleEnum locale) async {
    emit(LocaleState(locale: locale));
    await _repository.saveLocale(locale);
  }
}
