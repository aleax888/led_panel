import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Diálogo de selección de color del LED.
///
/// Devuelve el color elegido mediante `Navigator.pop` cuando el
/// usuario confirma, o `null` si cancela.
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
      title: const Text('Seleccionar color del LED'),
      content: SingleChildScrollView(
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
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_pickedColor),
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
