import 'package:flutter/material.dart';

import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Displays a label above an optional input widget.
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
