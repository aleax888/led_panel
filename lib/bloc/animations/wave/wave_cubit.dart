import 'package:led_panel/data/models/led_panel/animation_configs/wave_config_model.dart';
import 'package:led_panel/utils/angle_handler.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'wave_state.dart';

class WaveCubit extends Cubit<WaveState> {
  WaveCubit() : super(WaveState());

  void onAmplitudeChanged(double amplitude) {
    emit(state.copyWith(config: state.config.copyWith(amplitude: amplitude)));
  }

  void onFrequencyChanged(double frequency) {
    emit(state.copyWith(config: state.config.copyWith(frequency: frequency)));
  }

  void onPhaseStepChanged(int phaseStep) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          phaseStep: AngleHandler.degreesToRadians(phaseStep),
        ),
      ),
    );
  }
}
