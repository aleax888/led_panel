import 'package:flutter/material.dart';
import 'package:led_panel/data/led_panel_config_model.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_picker_dialog.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_preview.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Campo que muestra el color actual del LED y permite cambiarlo
/// a través de un selector de color presentado en un diálogo.
class ColorPickerField extends StatelessWidget {
  final LedPanelConfig config;
  final ValueChanged<Color> onColorChanged;

  const ColorPickerField({
    super.key,
    required this.config,
    required this.onColorChanged,
  });

  Future<void> _openColorPicker(BuildContext context) async {
    final Color? pickedColor = await showDialog<Color>(
      context: context,
      builder: (_) => ColorPickerDialog(initialColor: config.ledTextColor),
    );

    if (pickedColor != null) {
      onColorChanged(pickedColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openColorPicker(context),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: ColorPreview(color: config.ledTextColor),
          ),
          const InputLabel(label: 'Color del LED'),
        ],
      ),
    );
  }
}
