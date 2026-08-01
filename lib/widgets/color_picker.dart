import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:led_panel/domain/led_panel_config_model.dart';
import 'package:led_panel/widgets/input_label.dart';

class ColorPickerField extends StatelessWidget {
  final LedPanelConfig config;
  final Function(Color) onColorChanged;
  const ColorPickerField({
    super.key,
    required this.config,
    required this.onColorChanged,
  });

  void _showColorPicker(BuildContext context, Color currentColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Color pickerColor = currentColor;

        return AlertDialog(
          title: const Text('Seleccionar color del LED'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                pickerColor = color;
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                onColorChanged(pickerColor);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showColorPicker(context, config.ledTextColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: config.ledTextColor,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFF555555), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: config.ledTextColor.withOpacity(0.6),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
          InputLabel(label: 'Color del LED'),
        ],
      ),
    );
  }
}
