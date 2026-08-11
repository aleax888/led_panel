import 'package:flutter/material.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Diálogo para confirmar la eliminación de una configuración guardada.
class DeleteValidationDialog extends StatelessWidget {
  const DeleteValidationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Eliminar configuración',
        style: context.textTheme.titleMedium,
      ),
      content: Text(
        '¿Estás seguro de que deseas eliminar esta configuración guardada? Esta acción no se puede deshacer.',
        style: context.textTheme.bodyMedium,
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Cancelar',
            style: context.textTheme.labelLarge,
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
          ),
          child: Text(
            'Eliminar',
            style: context.textTheme.labelLarge?.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
