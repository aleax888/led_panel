import 'package:led_panel/data/models/led_panel/animation_configs/scramble_config_model.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scramble_state.dart';

class ScrambleCubit extends Cubit<ScrambleState> {
  ScrambleCubit({final ScrambleConfigModel? config}) : super(ScrambleState(config: config));

  void onCharacterDurationChanged(int characterDuration) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          characterDuration: Duration(milliseconds: characterDuration),
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

  void onScrambleCharactersChanged(String scrambleCharacters) {
    emit(
      state.copyWith(
        config: state.config.copyWith(scrambleCharacters: scrambleCharacters),
      ),
    );
  }
}
