import 'package:flutter/material.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_opacity.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Displays a square button for incrementing or decrementing a value.
class StepButton extends StatefulWidget {
  final String symbol;
  final VoidCallback? onPressed;

  const StepButton({super.key, required this.symbol, required this.onPressed});

  @override
  State<StepButton> createState() => _StepButtonState();
}

class _StepButtonState extends State<StepButton> {
  bool get isEnabled => widget.onPressed != null;

  Color get backgroundColor => isEnabled
      ? context.colors.primary
      : context.colors.primary.withAlpha(AppOpacity.disabled);

  Color get foregroundColor => isEnabled
      ? context.colors.onPrimary
      : context.colors.onPrimary.withAlpha(AppOpacity.disabled);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      borderRadius: AppRadius.borderRadiusMd,
      child: Container(
        padding: AppSpacing.inputPadding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: AppRadius.borderRadiusMd,
        ),
        child: Text(
          widget.symbol,
          style: context.textTheme.labelLarge?.copyWith(color: foregroundColor),
        ),
      ),
    );
  }
}
