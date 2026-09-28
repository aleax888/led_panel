import 'package:flutter/material.dart';
import 'package:led_panel/data/enums/dot_shape_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'led_panel_event.dart';
part 'led_panel_state.dart';

class LedPanelBloc extends Bloc<LedPanelEvent, LedPanelState> {
  LedPanelBloc() : super(const LedPanelState()) {
    on<LedPanelUnselected>(_onUnselected);
    on<LedPanelConfigSelected>(_onConfigSelected);
    // Text ----------------------------------------------
    on<LedPanelTextChanged>(_onTextChanged);
    on<LedPanelTextColorChanged>(_onTextColorChanged);
    on<LedPanelFontSizeChanged>(_onFontSizeChanged);
    on<LedPanelFontFamilyChanged>(_onFontFamilyChanged);
    on<LedPanelLetterSpacingChanged>(_onLetterSpacingChanged);
    on<LedPanelWordSpacingChanged>(_onWordSpacingChanged);
    on<LedPanelGlowRadiusChanged>(_onGlowRadiusChanged);
    // Animation ----------------------------------------------
    on<LedPanelAnimationTypeChanged>(_onAnimationTypeChanged);
    on<LedPanelAnimationConfigChanged>(_onAnimationConfigChanged);
    // Background ----------------------------------------------
    on<LedPanelBackgroundColorChanged>(_onBackgroundColorChanged);
    on<LedPanelLedsShapeChanged>(_onLedsShapeChanged);
    on<LedPanelLedsColorChanged>(_onLedsColorChanged);
  }

  void _onUnselected(LedPanelUnselected event, Emitter<LedPanelState> emit) {
    emit(const LedPanelState());
  }

  void _onConfigSelected(
    LedPanelConfigSelected event,
    Emitter<LedPanelState> emit,
  ) {
    event.config == null
        ? emit(const LedPanelState())
        : emit(state.copyWith(config: event.config));
  }

  // Text ----------------------------------------------
  void _onTextChanged(LedPanelTextChanged event, Emitter<LedPanelState> emit) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          text: state.config.text.copyWith(
            message: event.text.replaceAll('\n', ' '),
          ),
        ),
      ),
    );
  }

  void _onTextColorChanged(
    LedPanelTextColorChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          text: state.config.text.copyWith(color: event.color),
        ),
      ),
    );
  }

  void _onFontSizeChanged(
    LedPanelFontSizeChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          text: state.config.text.copyWith(fontSize: event.fontSize),
        ),
      ),
    );
  }

  void _onFontFamilyChanged(
    LedPanelFontFamilyChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          text: state.config.text.copyWith(fontFamily: event.fontFamily),
        ),
      ),
    );
  }

  void _onLetterSpacingChanged(
    LedPanelLetterSpacingChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          text: state.config.text.copyWith(letterSpacing: event.letterSpacing),
        ),
      ),
    );
  }

  void _onWordSpacingChanged(
    LedPanelWordSpacingChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          text: state.config.text.copyWith(wordSpacing: event.wordSpacing),
        ),
      ),
    );
  }

  void _onGlowRadiusChanged(
    LedPanelGlowRadiusChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          text: state.config.text.copyWith(glowRadius: event.glowRadius),
        ),
      ),
    );
  }

  // Animation ----------------------------------------------
  void _onAnimationTypeChanged(
    LedPanelAnimationTypeChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(config: state.config.copyWith(animation: event.config)),
    );
  }

  void _onAnimationConfigChanged(
    LedPanelAnimationConfigChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(config: state.config.copyWith(animation: event.config)),
    );
  }

  // Background ----------------------------------------------
  void _onBackgroundColorChanged(
    LedPanelBackgroundColorChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          background: state.config.background.copyWith(color: event.color),
        ),
      ),
    );
  }

  void _onLedsShapeChanged(
    LedPanelLedsShapeChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          background: state.config.background.copyWith(ledsShape: event.shape),
        ),
      ),
    );
  }

  void _onLedsColorChanged(
    LedPanelLedsColorChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          background: state.config.background.copyWith(ledsColor: event.color),
        ),
      ),
    );
  }
}
