import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:led_panel/data/led_panel_list_repository.dart';
import 'package:led_panel/data/shared_preferences_led_panel_list_repository.dart';
import 'package:led_panel/data/led_panel_config_model.dart';

part 'led_panel_list_event.dart';
part 'led_panel_list_state.dart';

class LedPanelListBloc extends Bloc<LedPanelListEvent, LedPanelListState> {
  LedPanelListBloc() : super(LedPanelListState()) {
    on<LedPanelListOpened>(_onOpened);
    on<LedPanelListConfigSaved>(_onConfigSaved);
    on<LedPanelListConfigDeleted>(_onConfigDeleted);
  }

  final LedPanelListRepository _repository =
      SharedPrefsLedPanelListRepository();

  Future<void> _onOpened(
    LedPanelListOpened event,
    Emitter<LedPanelListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final list = await _repository.getAll();
    emit(state.copyWith(configList: _sorted(list), isLoading: false));
  }

  Future<void> _onConfigSaved(
    LedPanelListConfigSaved event,
    Emitter<LedPanelListState> emit,
  ) async {
    await _repository.save(
      event.config.copyWith(
        id: event.config.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now(),
      ),
    );
    final list = await _repository.getAll();
    emit(state.copyWith(configList: _sorted(list)));
  }

  Future<void> _onConfigDeleted(
    LedPanelListConfigDeleted event,
    Emitter<LedPanelListState> emit,
  ) async {
    await _repository.delete(event.id);
    final list = await _repository.getAll();
    emit(state.copyWith(configList: _sorted(list)));
  }

  List<LedPanelConfigModel> _sorted(List<LedPanelConfigModel> list) {
    return [...list]
      ..sort((a, b) => b.createdAt?.compareTo(a.createdAt ?? DateTime(0)) ?? 0);
  }
}
