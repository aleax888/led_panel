import 'package:flutter/material.dart';
import 'package:led_panel/data/led_panel_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel_direction_enum.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'led_panel_event.dart';
part 'led_panel_state.dart';

class LedPanelBloc extends Bloc<LedPanelEvent, LedPanelState> {
  LedPanelBloc() : super(const LedPanelState()) {
    on<LedPanelTextChanged>(_onTextChanged);
    on<LedPanelTextColorChanged>(_onTextColorChanged);
    on<LedPanelFontSizeChanged>(_onFontSizeChanged);
    on<LedPanelFontFamilyChanged>(_onFontFamilyChanged);
    on<LedPanelLetterSpacingChanged>(_onLetterSpacingChanged);
    on<LedPanelWordSpacingChanged>(_onWordSpacingChanged);
    on<LedPanelGlowRadiusChanged>(_onGlowRadiusChanged);
    on<LedPanelSpeedChanged>(_onSpeedChanged);
    on<LedPanelDirectionChanged>(_onDirectionChanged);
    on<LedPanelBackgroundColorChanged>(_onBackgroundColorChanged);
    on<LedPanelLedsColorChanged>(_onLedsColorChanged);
  }

  void _onTextChanged(LedPanelTextChanged event, Emitter<LedPanelState> emit) {
    emit(state.copyWith(config: state.config.copyWith(text: event.text)));
  }

  void _onTextColorChanged(
    LedPanelTextColorChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(state.copyWith(config: state.config.copyWith(textColor: event.color)));
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

  void _onSpeedChanged(
    LedPanelSpeedChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(state.copyWith(config: state.config.copyWith(speed: event.speed)));
  }

  void _onDirectionChanged(
    LedPanelDirectionChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(config: state.config.copyWith(direction: event.direction)),
    );
  }

  void _onBackgroundColorChanged(
    LedPanelBackgroundColorChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(backgroundColor: event.color),
      ),
    );
  }

  void _onLedsColorChanged(
    LedPanelLedsColorChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(state.copyWith(config: state.config.copyWith(ledsColor: event.color)));
  }
}
