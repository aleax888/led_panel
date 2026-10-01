import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

/// Side menu option.
class SideMenuOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SideMenuOption({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      selectedTileColor: colorScheme.primaryContainer,
      selectedColor: colorScheme.onPrimaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.borderRadiusMd,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      minLeadingWidth: AppSizes.iconMd,
      leading: Icon(icon),
      title: Text(label, style: context.textTheme.labelLarge),
    );
  }
}
