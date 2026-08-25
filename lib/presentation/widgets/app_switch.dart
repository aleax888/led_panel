import 'package:flutter/material.dart';

import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Provides a switch for toggling bold text, styled with the configured LED color.
class AppSwitch extends StatelessWidget {
  final String label;
  final bool isOn;
  final ValueChanged<bool> onChanged;

  const AppSwitch({
    super.key,
    required this.label,
    required this.isOn,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.sm,
      children: [
        Switch(value: isOn, onChanged: onChanged),
        Text(label, style: context.textTheme.labelLarge),
      ],
    );
  }
}
