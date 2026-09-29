import 'dart:ui';

import 'package:led_panel/data/models/led_panel/background_config_model.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'background_state.dart';

class BackgroundCubit extends Cubit<BackgroundState> {
  BackgroundCubit({final BackgroundConfigModel? config})
    : super(BackgroundState(config: config));

  void onColorChanged(Color color) {
    emit(state.copyWith(config: state.config.copyWith(color: color)));
  }

  void onImageChanged(String path) {
    emit(state.copyWith(config: state.config.copyWith(imageUrl: path)));
  }
}
