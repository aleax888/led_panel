import 'package:flutter/material.dart';

import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_option.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_picker_dialog.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_preview.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Provides a color field with a preview, picker dialog, and quick color options.
class ColorPickerField extends StatefulWidget {
  final String? label;
  final Color? color;
  final ValueChanged<Color> onChanged;

  const ColorPickerField({
    super.key,
    this.label,
    required this.color,
    required this.onChanged,
  });

  @override
  State<ColorPickerField> createState() => _ColorPickerFieldState();
}

class _ColorPickerFieldState extends State<ColorPickerField> {
  late Color _selectedColor = widget.color ?? context.colors.primary;
  final List<Color> _colorOptions = [
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.lightGreen,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.blue,
    Colors.indigo,
    Colors.deepPurple,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.blueGrey,
    Colors.grey,
    Colors.black,
    Colors.white,
  ];

  @override
  void didUpdateWidget(covariant ColorPickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.color != null && oldWidget.color != widget.color) {
      _selectedColor = widget.color!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.sm,
      crossAxisAlignment: .end,
      children: [
        // Preview ----------------------------------------------
        GestureDetector(
          onTap: () => _openColorPicker(context),
          child: InputLabel(
            label: widget.label ?? context.locale.color,
            child: ColorPreview(color: _selectedColor),
          ),
        ),

        // Divider ----------------------------------------------
        SizedBox(
          height: AppSizes.avatarMd,
          child: VerticalDivider(
            radius: AppRadius.borderRadiusLg,
            indent: AppSpacing.sm,
            endIndent: AppSpacing.sm,
            color: context.colors.onSurfaceVariant,
          ),
        ),

        // Options ----------------------------------------------
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: .horizontal,
            child: Row(
              spacing: AppSpacing.sm,
              children: [
                ..._colorOptions.map(
                  (e) => ColorOption(color: e, onTap: () => _onColorChanged(e)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openColorPicker(BuildContext context) async {
    final Color? pickedColor = await showDialog<Color>(
      context: context,
      builder: (_) => ColorPickerDialog(initialColor: _selectedColor),
    );

    _onColorChanged(pickedColor);
  }

  void _onColorChanged(Color? color) {
    if (color == null) return;
    setState(() {
      _selectedColor = color;
    });
    widget.onChanged(color);
  }
}
