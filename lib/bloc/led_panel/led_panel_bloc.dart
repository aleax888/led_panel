import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/leds_config_model.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'led_panel_event.dart';
part 'led_panel_state.dart';

class LedPanelBloc extends Bloc<LedPanelEvent, LedPanelState> {
  LedPanelBloc() : super(const LedPanelState()) {
    on<LedPanelUnselected>(_onUnselected);
    on<LedPanelConfigSelected>(_onConfigSelected);
    // Text ----------------------------------------------
    on<LedPanelTextConfigChanged>(_onTextConfigChanged);
    // Animation ----------------------------------------------
    on<LedPanelAnimationTypeChanged>(_onAnimationTypeChanged);
    on<LedPanelAnimationConfigChanged>(_onAnimationConfigChanged);
    // Background ----------------------------------------------
    on<LedPanelBackgroundTypeChanged>(_onBackgroundTypeChanged);
    on<LedPanelBackgroundConfigChanged>(_onBackgroundConfigChanged);
    // Leds ----------------------------------------------
    on<LedPanelLedsConfigChanged>(_onLedsConfigChanged);
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
  void _onTextConfigChanged(
    LedPanelTextConfigChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(state.copyWith(config: state.config.copyWith(text: event.config)));
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
  void _onBackgroundTypeChanged(
    LedPanelBackgroundTypeChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(config: state.config.copyWith(background: event.config)),
    );
  }

  void _onBackgroundConfigChanged(
    LedPanelBackgroundConfigChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(
      state.copyWith(config: state.config.copyWith(background: event.config)),
    );
  }

  // Leds ----------------------------------------------
  void _onLedsConfigChanged(
    LedPanelLedsConfigChanged event,
    Emitter<LedPanelState> emit,
  ) {
    emit(state.copyWith(config: state.config.copyWith(leds: event.config)));
  }
}
