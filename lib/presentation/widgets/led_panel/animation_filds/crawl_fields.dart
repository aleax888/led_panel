import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/animations/crawl/crawl_cubit.dart';
import 'package:led_panel/data/enums/crawl_direction_enum.dart';
import 'package:led_panel/data/models/led_panel/animation_config_model.dart';
import 'package:led_panel/presentation/widgets/direction_selector/direction_selector.dart';
import 'package:led_panel/presentation/widgets/led_panel/animation_filds/animation_fields.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';

class CrawlFields extends AnimationFields {
  const CrawlFields();

  @override
  List<Widget> build(
    BuildContext context,
    void Function(AnimationConfigModel) sync,
  ) {
    final crawlCubit = context.watch<CrawlCubit>();
    final config = crawlCubit.state.config;

    return [
      DirectionSelector(
        options: CrawlTextDirectionEnum.values,
        selectedDirection: config.direction,
        onChanged: (direction) {
          crawlCubit.onDirectionChanged(direction);
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
          crawlCubit.onSpeedChanged(speed.toDouble());
          sync(config);
        },
      ),
      NumericValueSelector(
        label: 'TILT',
        unit: '°',
        value: config.tiltDegrees.round(),
        minValue: -90,
        maxValue: 90,
        incrementStep: 5,
        decrementStep: 5,
        onChanged: (tilt) {
          crawlCubit.onTiltChanged(tilt);
          sync(config);
        },
      ),
    ];
  }

  @override
  AnimationConfigModel currentConfig(BuildContext context) =>
      context.read<CrawlCubit>().state.config;
}
