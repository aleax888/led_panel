import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/configs/animations/marquee/marquee_cubit.dart';
import 'package:led_panel/data/enums/marquee_direction_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/animation_config_model.dart';
import 'package:led_panel/presentation/widgets/direction_selector/direction_selector.dart';
import 'package:led_panel/presentation/widgets/fields/animation_fields/animation_fields.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';

class MarqueeFields extends AnimationFields {
  const MarqueeFields();

  @override
  List<Widget> build(
    BuildContext context,
    void Function(AnimationConfigModel) sync,
  ) {
    final marqueeCubit = context.watch<MarqueeCubit>();
    marqueeCubit.stream.listen((state) {
      sync(state.config);
    });
    final config = marqueeCubit.state.config;

    return [
      DirectionSelector(
        options: MarqueeDirectionEnum.values,
        selectedDirection: config.direction,
        onChanged: (direction) => marqueeCubit.onDirectionChanged(direction),
      ),
      NumericValueSelector(
        label: 'SPEED',
        unit: 'px/s',
        value: config.speed.round(),
        minValue: 20,
        maxValue: 500,
        incrementStep: 5,
        decrementStep: 5,
        onChanged: (speed) => marqueeCubit.onSpeedChanged(speed.toDouble()),
      ),
    ];
  }

  @override
  AnimationConfigModel currentConfig(BuildContext context) =>
      context.read<MarqueeCubit>().state.config;
}
