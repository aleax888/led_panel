import 'dart:ui';

import 'package:led_panel/data/enums/dot_shape_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/leds_config_model.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'leds_state.dart';

class LedsCubit extends Cubit<LedsState> {
  LedsCubit({final LedsConfigModel? config}) : super(LedsState(config: config));

  void onColorChanged(Color color) {
    emit(state.copyWith(config: state.config.copyWith(color: color)));
  }

  void onShapeChanged(DotShapeEnum shape) {
    emit(state.copyWith(config: state.config.copyWith(shape: shape)));
  }

  void onSizeChanged(double size) {
    emit(state.copyWith(config: state.config.copyWith(size: size)));
  }

  void onPaddingChanged(double padding) {
    emit(state.copyWith(config: state.config.copyWith(padding: padding)));
  }
}
