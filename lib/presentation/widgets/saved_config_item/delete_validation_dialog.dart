import 'package:flutter/material.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_colors.dart';

/// Displays a dialog for confirming deletion of a saved configuration.
class DeleteValidationDialog extends StatelessWidget {
  const DeleteValidationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete configuration', style: context.textTheme.titleLarge),
      content: Text(
        'Are you sure you want to delete this?\nThis action cannot be undone.',
        style: context.textTheme.bodyMedium,
      ),
      actions: [
        // Cancel ----------------------------------------------
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel', style: context.textTheme.labelLarge),
        ),

        // Delete ----------------------------------------------
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
          child: Text('Delete'),
        ),
      ],
    );
  }
}
