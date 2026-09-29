import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/configs/backgrounds/solid_color/solid_color_cubit.dart';
import 'package:led_panel/data/models/led_panel/background_configs/background_config_model.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_picker_field.dart';
import 'package:led_panel/presentation/widgets/fields/background_fields/background_fields.dart';

class SolidColorFields implements BackgroundFields {
  const SolidColorFields();

  @override
  List<Widget> build(
    BuildContext context,
    void Function(BackgroundConfigModel) sync,
  ) {
    final solidColorCubit = context.watch<SolidColorCubit>();
    solidColorCubit.stream.listen((state) {
      sync(state.config);
    });
    final config = solidColorCubit.state.config;

    return [
      // Color ----------------------------------------------
      ColorPickerField(
        label: 'COLOR',
        color: config.color,
        onChanged: (color) => solidColorCubit.onColorChanged(color),
      ),
    ];
  }

  @override
  BackgroundConfigModel currentConfig(BuildContext context) =>
      context.read<SolidColorCubit>().state.config;
}
