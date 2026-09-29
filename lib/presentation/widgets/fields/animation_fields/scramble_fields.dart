import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/configs/animations/scramble/scramble_cubit.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/presentation/widgets/fields/animation_fields/animation_fields.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';

class ScrambleFields extends AnimationFields {
  const ScrambleFields();

  @override
  List<Widget> build(
    BuildContext context,
    void Function(AnimationConfigModel) sync,
  ) {
    final scrambleCubit = context.watch<ScrambleCubit>();
    scrambleCubit.stream.listen((state) {
      sync(state.config);
    });
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
        onChanged: (duration) =>
            scrambleCubit.onCharacterDurationChanged(duration),
      ),
      NumericValueSelector(
        label: 'COMPLETION PAUSE',
        unit: 'ms',
        value: config.completionPause.inMilliseconds,
        minValue: 0,
        maxValue: 5000,
        incrementStep: 50,
        decrementStep: 50,
        onChanged: (duration) =>
            scrambleCubit.onCompletionPauseChanged(duration),
      ),
      InputLabel(
        label: 'SCRAMBLE CHARACTERS',
        child: TextFormField(
          initialValue: config.scrambleCharacters,
          onChanged: (characters) =>
              scrambleCubit.onScrambleCharactersChanged(characters),
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
