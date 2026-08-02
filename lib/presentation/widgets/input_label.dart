import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/theme/constants/app_typography.dart';

/// Etiqueta pequeña que identifica un campo de entrada.
///
/// Usa una tipografía monoespaciada con tracking amplio para transmitir
/// una estética de lectura técnica, acorde a la identidad visual del panel LED.
class InputLabel extends StatelessWidget {
  final String label;
  final Widget? child;

  const InputLabel({super.key, required this.label, this.child});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      spacing: AppSpacing.sm,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            fontSize: AppTypography.sizeOverline,
            letterSpacing: AppTypography.letterSpacingWidest,
            fontWeight: AppTypography.bold,
          ),
        ),
        ?child,
      ],
    );
  }
}
