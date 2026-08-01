import 'package:flutter/material.dart';
import 'package:led_panel/domain/led_panel_config_model.dart';

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
    on<LedPanelGlowRadiusChanged>(_onGlowRadiusChanged);
    on<LedPanelBorderRadiusChanged>(_onBorderRadiusChanged);
    on<LedPanelFontWeightChanged>(_onFontWeightChanged);
  }

  void _onTextChanged(LedPanelTextChanged event, Emitter<LedPanelState> emit) {
    emit(state.copyWith(config: state.config.copyWith(text: event.text)));
  }

  void _onColorChanged(
    LedPanelColorChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(
          ledTextColor: event.color,
          panelBackgroundColor: const Color(0xFF0A0A0A),
          borderColor: const Color(0xFF333333),
        ),
      ),
    );
  }

  void _onSpeedChanged(
    LedPanelSpeedChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(scrollSpeedPixelsPerSecond: event.speed),
      ),
    );
  }

  void _onFontSizeChanged(
    LedPanelFontSizeChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(config: state.config.copyWith(fontSize: event.fontSize)),
    );
  }

  void _onGlowRadiusChanged(
    LedPanelGlowRadiusChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(ledGlowRadius: event.glowRadius),
      ),
    );
  }

  void _onBorderRadiusChanged(
    LedPanelBorderRadiusChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(borderRadius: event.borderRadius),
      ),
    );
  }

  void _onFontWeightChanged(
    LedPanelFontWeightChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(
        config: state.config.copyWith(fontWeight: event.fontWeight),
      ),
    );
  }
}
