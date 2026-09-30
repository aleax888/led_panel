import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/configs/backgrounds/linear_gradient/linear_gradient_cubit.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';
import 'package:led_panel/presentation/widgets/fields/background_fields/background_fields.dart';
import 'package:led_panel/presentation/widgets/gradient_editor/gradient_editor.dart';
import 'package:led_panel/presentation/widgets/gradient_editor/gradient_stop.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';

class LinearGradientFields implements BackgroundFields {
  const LinearGradientFields();

  @override
  List<Widget> build(
    BuildContext context,
    void Function(BackgroundConfigModel) sync,
  ) {
    final linearGradientCubit = context.watch<LinearGradientCubit>();
    linearGradientCubit.stream.listen((state) {
      sync(state.config);
    });
    final config = linearGradientCubit.state.config;
    final List<GradientStop> stops = List.generate(
      config.colors.length,
      (index) => GradientStop(
        position: (config.stops[index] * 100).round(),
        color: config.colors[index],
      ),
    );

    return [
      // Gradient ----------------------------------------------
      GradientEditor(
        stops: stops,
        onChanged: (updatedStops) => linearGradientCubit.onGradientChanged(
          updatedStops.map((stop) => stop.color).toList(),
          updatedStops.map((stop) => stop.position / 100).toList(),
        ),
      ),

      // Tilt
      NumericValueSelector(
        label: 'TILT',
        unit: '°',
        value: config.tiltDegrees.round(),
        minValue: 00,
        maxValue: 360,
        incrementStep: 5,
        decrementStep: 5,
        onChanged: (tilt) => linearGradientCubit.onTiltChanged(tilt),
      ),
    ];
  }

  @override
  BackgroundConfigModel currentConfig(BuildContext context) =>
      context.read<LinearGradientCubit>().state.config;
}
