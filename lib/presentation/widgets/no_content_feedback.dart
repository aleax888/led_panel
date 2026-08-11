import 'package:flutter/material.dart';

import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Widget para mostrar un estado vacío en listas.
class NoContentFeedback extends StatelessWidget {
  const NoContentFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          spacing: AppSpacing.md,
          mainAxisSize: .min,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: AppSizes.iconXl,
              color: context.theme.disabledColor,
            ),
            Text(
              'You don\'t have any items yet',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.theme.disabledColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
