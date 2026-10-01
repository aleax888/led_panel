import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

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
      title: Text('Select color', style: context.textTheme.titleLarge),
      content: SingleChildScrollView(
        // Main color selection control ----------------------------------------------
        child: ColorPicker(
          pickerColor: _pickedColor,
          onColorChanged: (Color color) => setState(() => _pickedColor = color),
        ),
      ),
      actions: [
        // Cancel button ----------------------------------------------
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),

        // Done button ----------------------------------------------
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _pickedColor),
          child: Text('Done'),
        ),
      ],
    );
  }
}
