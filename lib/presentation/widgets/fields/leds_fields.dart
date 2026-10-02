import 'package:flutter/material.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/configs/leds/leds_cubit.dart';
import 'package:led_panel/data/models/led_panel/animation_configs/leds_config_model.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_picker_field.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';
import 'package:led_panel/presentation/widgets/shape_selector/shape_selector.dart';

/// Class that builds the LED fields for the LED configuration.
class LedsFields {
  const LedsFields();

  List<Widget> build(
    BuildContext context,
    void Function(LedsConfigModel) sync,
  ) {
    final ledsCubit = context.watch<LedsCubit>();
    ledsCubit.stream.listen((state) {
      sync(state.config);
    });
    final config = ledsCubit.state.config;

    return [
      // Color ----------------------------------------------
      ColorPickerField(
        label: context.locale.leds,
        color: config.color,
        onChanged: (color) => ledsCubit.onColorChanged(color),
      ),

      // Shape ----------------------------------------------
      ShapeSelector(
        selectedShape: config.shape,
        onChanged: (shape) => ledsCubit.onShapeChanged(shape),
      ),

      // Size ----------------------------------------------
      NumericValueSelector(
        label: context.locale.ledsSize,
        unit: 'pt',
        value: config.size.round(),
        minValue: 8,
        maxValue: 20,
        incrementStep: 2,
        decrementStep: 2,
        onChanged: (size) => ledsCubit.onSizeChanged(size.toDouble()),
      ),

      // Padding ----------------------------------------------
      NumericValueSelector(
        label: context.locale.ledsPadding,
        unit: 'pt',
        value: config.padding.round(),
        minValue: 0,
        maxValue: 5,
        incrementStep: 2,
        decrementStep: 2,
        onChanged: (padding) => ledsCubit.onPaddingChanged(padding.toDouble()),
      ),
    ];
  }
}
