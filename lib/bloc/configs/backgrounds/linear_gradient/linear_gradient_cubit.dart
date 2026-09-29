import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/background_configs/linear_gradient_config_model.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'linear_gradient_state.dart';

class LinearGradientCubit extends Cubit<LinearGradientState> {
  LinearGradientCubit({final LinearGradientConfigModel? config})
    : super(LinearGradientState(config: config));

  void onSpeedChanged(LinearGradient gradient) {
    emit(state.copyWith(config: state.config.copyWith(gradient: gradient)));
  }
}
