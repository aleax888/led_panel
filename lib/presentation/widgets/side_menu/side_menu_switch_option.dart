import 'package:flutter/material.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

class SideMenuSwitchOption extends StatelessWidget {
  final bool value;
  final IconData icon;
  final Function(bool) onChanged;
  const SideMenuSwitchOption({
    super.key,
    required this.value,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      secondary: Icon(icon),
      title: Text('THEME', style: context.textTheme.labelLarge),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    );
  }
}
