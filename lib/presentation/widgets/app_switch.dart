import 'package:flutter/material.dart';

/// Interruptor para alternar el peso de la fuente (negrita), con su
/// color activo ligado al color del LED configurado.
class AppSwitch extends StatelessWidget {
  final bool isOn;
  final ValueChanged<bool> onChanged;

  const AppSwitch({super.key, required this.isOn, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(value: isOn, onChanged: onChanged),
        const Text('NEGRITA'),
      ],
    );
  }
}
