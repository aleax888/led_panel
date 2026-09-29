import 'dart:ui';

import 'package:led_panel/data/models/led_panel/text_config_model.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'text_state.dart';

class TextCubit extends Cubit<TextState> {
  TextCubit({final TextConfigModel? config}) : super(TextState(config: config));

  void onMessageChanged(String message) {
    emit(
      state.copyWith(
        config: state.config.copyWith(message: message.replaceAll('\n', ' ')),
      ),
    );
  }

  void onColorChanged(Color color) {
    emit(state.copyWith(config: state.config.copyWith(color: color)));
  }

  void onFontSizeChanged(double fontSize) {
    emit(state.copyWith(config: state.config.copyWith(fontSize: fontSize)));
  }

  void onFontFamilyChanged(String fontFamily) {
    emit(state.copyWith(config: state.config.copyWith(fontFamily: fontFamily)));
  }

  void onLetterSpacingChanged(double letterSpacing) {
    emit(
      state.copyWith(
        config: state.config.copyWith(letterSpacing: letterSpacing),
      ),
    );
  }

  void onWordSpacingChanged(double wordSpacing) {
    emit(
      state.copyWith(config: state.config.copyWith(wordSpacing: wordSpacing)),
    );
  }

  void onGlowRadiusChanged(double glowRadius) {
    emit(state.copyWith(config: state.config.copyWith(glowRadius: glowRadius)));
  }
}
