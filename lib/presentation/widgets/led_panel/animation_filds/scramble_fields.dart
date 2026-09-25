import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/animations/scramble/scramble_cubit.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_filds/animation_fields.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';

class ScrambleFields extends AnimationFields {
  const ScrambleFields();

  @override
  List<Widget> build(
    BuildContext context,
    void Function(AnimationConfigModel) sync,
  ) {
    final scrambleCubit = context.watch<ScrambleCubit>();
    final config = scrambleCubit.state.config;

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
          scrambleCubit.onCharacterDurationChanged(duration);
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
          scrambleCubit.onCompletionPauseChanged(duration);
          sync(config);
        },
      ),
      InputLabel(
        label: 'SCRAMBLE CHARACTERS',
        child: TextFormField(
          initialValue: config.scrambleCharacters,
          onChanged: (characters) {
            scrambleCubit.onScrambleCharactersChanged(characters);
            sync(config);
          },
          onEditingComplete: () => FocusScope.of(context).unfocus(),
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
        ),
      ),
    ];
  }

  @override
  AnimationConfigModel currentConfig(BuildContext context) =>
      context.read<ScrambleCubit>().state.config;
}
