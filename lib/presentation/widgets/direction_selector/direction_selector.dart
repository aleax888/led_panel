import 'package:flutter/material.dart';
import 'package:led_panel/presentation/widgets/direction_selector/direction_selector_option.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel_direction_enum.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Selector horizontal del sentido del desplazamiento del texto.
class DirectionSelector extends StatelessWidget {
  final LedPanelDirectionEnum selectedDirection;
  final ValueChanged<LedPanelDirectionEnum>? onChanged;

  const DirectionSelector({
    super.key,
    required this.selectedDirection,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputLabel(
      label: 'DIRECCIÓN',
      child: SizedBox(
        height: AppSizes.avatarMd,
        child: Row(
          spacing: AppSpacing.md,
          children: [
            ...LedPanelDirectionEnum.values.map(
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
