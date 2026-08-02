import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_opacity.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/theme/constants/app_typography.dart';

/// Botón cuadrado con un símbolo, usado para incrementar o decrementar
/// el valor del [NumericValueSelector] en un paso específico.
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
      ? Theme.of(context).colorScheme.primary
      : Theme.of(context).colorScheme.primary.withAlpha(AppOpacity.disabled);

  Color get foregroundColor => isEnabled
      ? Theme.of(context).colorScheme.onPrimary
      : Theme.of(context).colorScheme.onPrimary.withAlpha(AppOpacity.disabled);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        onTap: widget.onPressed,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Text(
            widget.symbol,
            style: TextStyle(
              color: foregroundColor,
              fontSize: AppTypography.sizeTitleLg,
              fontWeight: AppTypography.bold,
            ),
          ),
        ),
      ),
    );
  }
}
