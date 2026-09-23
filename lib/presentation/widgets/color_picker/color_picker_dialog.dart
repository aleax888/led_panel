import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Displays a dialog for selecting an LED color.
class ColorPickerDialog extends StatefulWidget {
  final Color initialColor;

  const ColorPickerDialog({super.key, required this.initialColor});

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color _pickedColor = widget.initialColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select LED color', style: context.textTheme.titleMedium),
      content: SingleChildScrollView(
        // Main color selection control ----------------------------------------------
        child: ColorPicker(
          pickerColor: _pickedColor,
          onColorChanged: (Color color) => setState(() => _pickedColor = color),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      actions: [
        // Cancel button ----------------------------------------------
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: context.textTheme.labelLarge),
        ),

        // Done button ----------------------------------------------
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_pickedColor),
          child: Text(
            'Done',
            style: context.textTheme.labelLarge?.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
