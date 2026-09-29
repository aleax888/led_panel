import 'package:led_panel/data/models/led_panel/animation_configs/typewriter_config_model.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'typewritter_state.dart';

class TypewritterCubit extends Cubit<TypewritterState> {
  TypewritterCubit({final TypewriterConfigModel? config})
    : super(TypewritterState(config: config));

  void onCharacterDurationChanged(int characterDuration) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          characterDuration: Duration(milliseconds: characterDuration),
        ),
      ),
    );
  }

  void onCharacterDurationNoiseChanged(int characterDurationNoise) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          characterDurationNoise: Duration(
            milliseconds: characterDurationNoise,
          ),
        ),
      ),
    );
  }

  void onCompletionPauseChanged(int completionPause) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          completionPause: Duration(milliseconds: completionPause),
        ),
      ),
    );
  }
}
