import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/configs/background/background_cubit.dart';
import 'package:led_panel/data/models/led_panel/background_config_model.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_picker_field.dart';

class BackgroundFields {
  const BackgroundFields();

  List<Widget> build(
    BuildContext context,
    void Function(BackgroundConfigModel) sync,
  ) {
    final backgroundCubit = context.watch<BackgroundCubit>();
    backgroundCubit.stream.listen((state) {
      sync(state.config);
    });
    final config = backgroundCubit.state.config;

    return [
      // Color ----------------------------------------------
      ColorPickerField(
        label: 'BG',
        color: config.color,
        onChanged: (color) => backgroundCubit.onColorChanged(color),
      ),
    ];
  }
}
