import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/configs/backgrounds/linear_gradient/linear_gradient_cubit.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';
import 'package:led_panel/presentation/widgets/fields/background_fields/background_fields.dart';

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

    return [
      // Gradient ----------------------------------------------
    ];
  }

  @override
  BackgroundConfigModel currentConfig(BuildContext context) =>
      context.read<LinearGradientCubit>().state.config;
}
