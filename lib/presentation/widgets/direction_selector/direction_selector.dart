import 'package:flutter/material.dart';
import 'package:led_panel/presentation/widgets/direction_selector/direction_selector_option.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Displays a horizontal selector for the text scrolling direction.
class DirectionSelector<T> extends StatelessWidget {
  final List options;
  final T selectedDirection;
  final ValueChanged<T>? onChanged;

  const DirectionSelector({
    super.key,
    required this.options,
    required this.selectedDirection,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputLabel(
      label: 'DIRECTION',
      child: SizedBox(
        height: AppSizes.avatarMd,
        child: Row(
          spacing: AppSpacing.md,
          children: [
            // Options ----------------------------------------------
            ...options.map(
              (e) => Expanded(
                child: DirectionSelectorOption(
                  label: e.label,
                  icon: e.icon,
                  selected: e == selectedDirection,
                  onTap: () => onChanged?.call(e),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
