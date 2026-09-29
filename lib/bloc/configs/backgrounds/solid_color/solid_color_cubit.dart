import 'dart:ui';

import 'package:led_panel/data/models/led_panel/background_configs/solid_color_config_model.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'solid_color_state.dart';

class SolidColorCubit extends Cubit<SolidColorState> {
  SolidColorCubit({final SolidColorConfigModel? config})
    : super(SolidColorState(config: config));

  void onColorChanged(Color color) {
    emit(state.copyWith(config: state.config.copyWith(color: color)));
  }
}
