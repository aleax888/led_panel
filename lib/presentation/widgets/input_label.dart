import 'package:flutter/material.dart';

import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Etiqueta pequeña que identifica un campo de entrada.
class InputLabel extends StatelessWidget {
  final String label;
  final Widget? child;

  const InputLabel({super.key, required this.label, this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: AppSpacing.sm,
      children: [
        Text(label, style: context.textTheme.labelLarge),
        ?child,
      ],
    );
  }
}
