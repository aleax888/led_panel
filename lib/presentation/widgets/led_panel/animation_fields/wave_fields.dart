import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/animations/wave/wave_cubit.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_fields/animation_fields.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';

class WaveFields extends AnimationFields {
  const WaveFields();

  @override
  List<Widget> build(BuildContext context, void Function(AnimationConfigModel) sync) {
    final waveCubit = context.watch<WaveCubit>();
    final config = waveCubit.state.config;

    return [
      NumericValueSelector(
        label: 'AMPLITUDE',
        unit: 'px',
        value: config.amplitude.round(),
        minValue: 0,
        maxValue: 50,
        incrementStep: 5,
        decrementStep: 5,
        onChanged: (amplitude) {
          waveCubit.onAmplitudeChanged(amplitude.toDouble());
          sync(config);
        },
      ),
      NumericValueSelector(
        label: 'FREQUENCY',
        unit: 'Hz',
        value: config.frequency.round(),
        minValue: 0,
        maxValue: 20,
        incrementStep: 5,
        decrementStep: 5,
        onChanged: (frequency) {
          waveCubit.onFrequencyChanged(frequency.toDouble());
          sync(config);
        },
      ),
      NumericValueSelector(
        label: 'PHASE STEP',
        unit: '°',
        value: config.phaseStepDegrees.round(),
        minValue: 0,
        maxValue: 180,
        incrementStep: 5,
        decrementStep: 5,
        onChanged: (phaseStep) {
          waveCubit.onPhaseStepChanged(phaseStep);
          sync(config);
        },
      ),
    ];
  }

  @override
  AnimationConfigModel currentConfig(BuildContext context) =>
      context.read<WaveCubit>().state.config;
}
