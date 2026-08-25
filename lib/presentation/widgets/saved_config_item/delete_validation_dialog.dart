import 'package:flutter/material.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Displays a dialog for confirming deletion of a saved configuration.
class DeleteValidationDialog extends StatelessWidget {
  const DeleteValidationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete configuration',
        style: context.textTheme.titleMedium,
      ),
      content: Text(
        'Are you sure you want to delete this saved configuration? This action cannot be undone.',
        style: context.textTheme.bodyMedium,
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      actions: [
        // Cancel ----------------------------------------------
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Cancel',
            style: context.textTheme.labelLarge,
          ),
        ),

        // Delete ----------------------------------------------
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
          ),
          child: Text(
            'Delete',
            style: context.textTheme.labelLarge?.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
