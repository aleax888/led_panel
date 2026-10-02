import 'package:flutter/material.dart';

import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Displays feedback when a list has no content.
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
              context.locale.emptyItems,
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
