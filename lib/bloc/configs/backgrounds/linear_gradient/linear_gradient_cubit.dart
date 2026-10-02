import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/background_configs/linear_gradient_config_model.dart';
import 'package:led_panel/utils/angle_handler.dart';

import 'package:bloc/bloc.dart';

part 'linear_gradient_state.dart';

class LinearGradientCubit extends Cubit<LinearGradientState> {
  LinearGradientCubit({final LinearGradientConfigModel? config})
    : super(LinearGradientState(config: config));

  void onColorsChanged(List<Color> colors) {
    emit(state.copyWith(config: state.config.copyWith(colors: colors)));
  }

  void onStopsChanged(List<double> stops) {
    emit(state.copyWith(config: state.config.copyWith(stops: stops)));
  }

  void onGradientChanged(List<Color> colors, List<double> stops) {
    emit(
      state.copyWith(
        config: state.config.copyWith(colors: colors, stops: stops),
      ),
    );
  }

  void onTiltChanged(int tilt) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          tilt: AngleHandler.degreesToRadians(tilt),
        ),
      ),
    );
  }
}
