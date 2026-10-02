import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/configs/text/text_cubit.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_picker_field.dart';
import 'package:led_panel/presentation/widgets/font_family_selector/font_family_selector.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';

/// Class that builds the text fields for the text configuration.
class TextFields {
  const TextFields();

  List<Widget> build(
    BuildContext context,
    FocusNode focusNode,
    void Function(TextConfigModel) sync,
  ) {
    final textCubit = context.watch<TextCubit>();
    textCubit.stream.listen((state) {
      sync(state.config);
    });
    final config = textCubit.state.config;

    return [
      // Message ----------------------------------------------
      TextFormField(
        initialValue: config.message,
        focusNode: focusNode,
        onChanged: (message) => textCubit.onMessageChanged(message),
        onEditingComplete: () => focusNode.unfocus(),
        onTapOutside: (event) => focusNode.unfocus(),
        maxLines: 2,
        minLines: 1,
        decoration: InputDecoration(hintText: 'Type your message...'),
      ),

      // Color ----------------------------------------------
      ColorPickerField(
        color: config.color,
        onChanged: (color) => textCubit.onColorChanged(color),
      ),

      // Font Family ----------------------------------------------
      FontFamilySelector(
        selectedFontFamily: config.fontFamily,
        onChanged: (fontFamily) => textCubit.onFontFamilyChanged(fontFamily),
      ),

      // Font Size ----------------------------------------------
      NumericValueSelector(
        label: 'SIZE',
        unit: 'pt',
        value: config.fontSize.round(),
        minValue: 100,
        maxValue: 300,
        incrementStep: 2,
        decrementStep: 2,
        onChanged: (size) => textCubit.onFontSizeChanged(size.toDouble()),
      ),

      // Glow Radius ----------------------------------------------
      NumericValueSelector(
        label: 'GLOW',
        unit: 'pt',
        value: config.glowRadius.round(),
        minValue: 0,
        maxValue: 50,
        incrementStep: 1,
        decrementStep: 1,
        onChanged: (radius) => textCubit.onGlowRadiusChanged(radius.toDouble()),
      ),

      // Letter Spacing ----------------------------------------------
      NumericValueSelector(
        label: 'LETTER SPACING',
        unit: 'pt',
        value: config.letterSpacing.round(),
        minValue: -10,
        maxValue: 50,
        incrementStep: 1,
        decrementStep: 1,
        onChanged: (spacing) =>
            textCubit.onLetterSpacingChanged(spacing.toDouble()),
      ),

      // Word Spacing ----------------------------------------------
      NumericValueSelector(
        label: 'WORD SPACING',
        unit: 'pt',
        value: config.wordSpacing.round(),
        minValue: -10,
        maxValue: 50,
        incrementStep: 1,
        decrementStep: 1,
        onChanged: (spacing) =>
            textCubit.onWordSpacingChanged(spacing.toDouble()),
      ),
    ];
  }
}
