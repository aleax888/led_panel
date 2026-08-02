import 'package:flutter/material.dart';

import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_picker_dialog.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_preview.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';

/// Campo que muestra el color actual del LED y permite cambiarlo
/// a través de un selector de color presentado en un diálogo.
class ColorPickerField extends StatefulWidget {
  final Color? color;
  final ValueChanged<Color> onChanged;

  const ColorPickerField({
    super.key,
    required this.color,
    required this.onChanged,
  });

  @override
  State<ColorPickerField> createState() => _ColorPickerFieldState();
}

class _ColorPickerFieldState extends State<ColorPickerField> {
  late Color _selectedColor = widget.color ?? context.colors.primary;

  @override
  void didUpdateWidget(covariant ColorPickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.color != null && oldWidget.color != widget.color) {
      _selectedColor = widget.color!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openColorPicker(context),
      child: InputLabel(
        label: 'Color',
        child: ColorPreview(color: _selectedColor),
      ),
    );
  }

  Future<void> _openColorPicker(BuildContext context) async {
    final Color? pickedColor = await showDialog<Color>(
      context: context,
      builder: (_) => ColorPickerDialog(initialColor: _selectedColor),
    );

    if (pickedColor != null) {
      setState(() {
        _selectedColor = pickedColor;
      });
      widget.onChanged(pickedColor);
    }
  }
}
