import 'package:flutter/material.dart';
import 'package:led_panel/presentation/widgets/direction_selector/direction_selector_option.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/data/enums/marquee_direction_enum.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Displays a horizontal selector for the text scrolling direction.
class DirectionSelector extends StatelessWidget {
  final MarqueeDirectionEnum selectedDirection;
  final ValueChanged<MarqueeDirectionEnum>? onChanged;

  const DirectionSelector({
    super.key,
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
            ...MarqueeDirectionEnum.values.map(
              (e) => Expanded(
                child: DirectionSelectorOption(
                  direction: e,
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
