import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/animations/marquee/marquee_cubit.dart';
import 'package:led_panel/data/enums/marquee_direction_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';
import 'package:led_panel/presentation/widgets/direction_selector/direction_selector.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_filds/animation_fields.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';

class MarqueeFields extends AnimationFields {
  const MarqueeFields();

  @override
  List<Widget> build(
    BuildContext context,
    void Function(AnimationConfigModel) sync,
  ) {
    final marqueeCubit = context.watch<MarqueeCubit>();
    final config = marqueeCubit.state.config;

    return [
      DirectionSelector(
        options: MarqueeDirectionEnum.values,
        selectedDirection: config.direction,
        onChanged: (direction) {
          marqueeCubit.onDirectionChanged(direction);
          sync(config);
        },
      ),
      NumericValueSelector(
        label: 'SPEED',
        unit: 'px/s',
        value: config.speed.round(),
        minValue: 20,
        maxValue: 500,
        incrementStep: 5,
        decrementStep: 5,
        onChanged: (speed) {
          marqueeCubit.onSpeedChanged(speed.toDouble());
          sync(config);
        },
      ),
    ];
  }

  @override
  AnimationConfigModel currentConfig(BuildContext context) =>
      context.read<MarqueeCubit>().state.config;
}
