import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/animations/typewritter/typewritter_cubit.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_fields/animation_fields.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';

class TypewriterFields extends AnimationFields {
  const TypewriterFields();

  @override
  List<Widget> build(BuildContext context, void Function(AnimationConfigModel) sync) {
    final typewritterCubit = context.watch<TypewritterCubit>();
    final config = typewritterCubit.state.config;

    return [
      NumericValueSelector(
        label: 'CHARACTER DURATION',
        unit: 'ms',
        value: config.characterDuration.inMilliseconds,
        minValue: 20,
        maxValue: 500,
        incrementStep: 5,
        decrementStep: 5,
        onChanged: (duration) {
          typewritterCubit.onCharacterDurationChanged(duration);
          sync(config);
        },
      ),
      NumericValueSelector(
        label: 'CHARACTER DURATION NOISE',
        unit: 'ms',
        value: config.characterDurationNoise.inMilliseconds,
        minValue: 0,
        maxValue: 1000,
        incrementStep: 10,
        decrementStep: 10,
        onChanged: (duration) {
          typewritterCubit.onCharacterDurationNoiseChanged(duration);
          sync(config);
        },
      ),
      NumericValueSelector(
        label: 'COMPLETION PAUSE',
        unit: 'ms',
        value: config.completionPause.inMilliseconds,
        minValue: 0,
        maxValue: 5000,
        incrementStep: 50,
        decrementStep: 50,
        onChanged: (duration) {
          typewritterCubit.onCompletionPauseChanged(duration);
          sync(config);
        },
      ),
    ];
  }

  @override
  AnimationConfigModel currentConfig(BuildContext context) =>
      context.read<TypewritterCubit>().state.config;
}
