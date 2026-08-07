import 'package:flutter/material.dart';
import 'package:led_panel/data/led_panel_config_model.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'led_panel_event.dart';
part 'led_panel_state.dart';

class LedPanelBloc extends Bloc<LedPanelEvent, LedPanelState> {
  LedPanelBloc() : super(const LedPanelState()) {
    on<LedPanelTextChanged>(_onTextChanged);
    on<LedPanelColorChanged>(_onColorChanged);
    on<LedPanelSpeedChanged>(_onSpeedChanged);
    on<LedPanelFontSizeChanged>(_onFontSizeChanged);
    on<LedPanelFontFamilyChanged>(_onFontFamilyChanged);
    on<LedPanelLetterSpacingChanged>(_onLetterSpacingChanged);
    on<LedPanelWordSpacingChanged>(_onWordSpacingChanged);
    on<LedPanelGlowRadiusChanged>(_onGlowRadiusChanged);
  }

  void _onTextChanged(LedPanelTextChanged event, Emitter<LedPanelState> emit) {
    emit(state.copyWith(config: state.config.copyWith(text: event.text)));
  }

  void _onColorChanged(
    LedPanelColorChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(state.copyWith(config: state.config.copyWith(color: event.color)));
  }

  void _onSpeedChanged(
    LedPanelSpeedChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(state.copyWith(config: state.config.copyWith(speed: event.speed)));
  }

  void _onFontSizeChanged(
    LedPanelFontSizeChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(config: state.config.copyWith(fontSize: event.fontSize)),
    );
  }

  void _onFontFamilyChanged(
    LedPanelFontFamilyChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(fontFamily: event.fontFamily),
      ),
    );
  }

  void _onLetterSpacingChanged(
    LedPanelLetterSpacingChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(letterSpacing: event.letterSpacing),
      ),
    );
  }

  void _onWordSpacingChanged(
    LedPanelWordSpacingChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(wordSpacing: event.wordSpacing),
      ),
    );
  }

  void _onGlowRadiusChanged(
    LedPanelGlowRadiusChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(glowRadius: event.glowRadius),
      ),
    );
  }
}
