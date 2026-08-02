import 'package:flutter/material.dart';

import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Interruptor para alternar el peso de la fuente (negrita), con su
/// color activo ligado al color del LED configurado.
class AppSwitch extends StatelessWidget {
  final bool isOn;
  final ValueChanged<bool> onChanged;

  const AppSwitch({super.key, required this.isOn, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.sm,
      children: [
        Switch(value: isOn, onChanged: onChanged),
        Text('NEGRITA', style: context.textTheme.labelLarge),
      ],
    );
  }
}
