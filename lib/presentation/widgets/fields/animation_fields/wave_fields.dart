import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/configs/animations/wave/wave_cubit.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/presentation/widgets/fields/animation_fields/animation_fields.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';

/// Class that builds the wave fields for the wave animation configuration.
class WaveFields extends AnimationFields {
  const WaveFields();

  @override
  List<Widget> build(
    BuildContext context,
    void Function(AnimationConfigModel) sync,
  ) {
    final waveCubit = context.watch<WaveCubit>();
    waveCubit.stream.listen((state) {
      sync(state.config);
    });
    final config = waveCubit.state.config;

    return [
      // Amplitude ----------------------------------------------
      NumericValueSelector(
        label: 'AMPLITUDE',
        unit: 'px',
        value: config.amplitude.round(),
        minValue: 0,
        maxValue: 50,
        incrementStep: 5,
        decrementStep: 5,
        onChanged: (amplitude) =>
            waveCubit.onAmplitudeChanged(amplitude.toDouble()),
      ),

      // Frequency ----------------------------------------------
      NumericValueSelector(
        label: 'FREQUENCY',
        unit: 'Hz',
        value: config.frequency.round(),
        minValue: 0,
        maxValue: 20,
        incrementStep: 5,
        decrementStep: 5,
        onChanged: (frequency) =>
            waveCubit.onFrequencyChanged(frequency.toDouble()),
      ),

      // Phase Step ----------------------------------------------
      NumericValueSelector(
        label: 'PHASE STEP',
        unit: '°',
        value: config.phaseStepDegrees.round(),
        minValue: 0,
        maxValue: 180,
        incrementStep: 5,
        decrementStep: 5,
        onChanged: (phaseStep) => waveCubit.onPhaseStepChanged(phaseStep),
      ),
    ];
  }

  @override
  AnimationConfigModel currentConfig(BuildContext context) =>
      context.read<WaveCubit>().state.config;
}
