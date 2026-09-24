import 'package:flutter/material.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/data/enums/marquee_direction_enum.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/theme/constants/app_typography.dart';

/// Displays a selectable panel animation direction option.
class DirectionSelectorOption extends StatelessWidget {
  final MarqueeDirectionEnum direction;
  final bool selected;
  final VoidCallback? onTap;

  const DirectionSelectorOption({
    super.key,
    required this.direction,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: direction.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.borderRadiusLg,
        child: Container(
          height: AppSizes.avatarLg,
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: AppRadius.borderRadiusLg,
            border: Border.all(
              color: selected ? context.colors.primary : context.colors.outline,
              width: selected
                  ? AppSizes.borderWidthThick
                  : AppSizes.borderWidthThin,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            mainAxisAlignment: .center,
            spacing: AppSpacing.sm,
            children: [
              // Option icon ----------------------------------------------
              Icon(
                direction.icon,
                size: AppSizes.iconMd,
                color: selected
                    ? context.colors.primary
                    : context.colors.onSurface,
              ),

              // Option label ----------------------------------------------
              Text(
                direction.label,
                style: TextStyle(
                  fontFamily: AppTypography.fontRoboto,
                  fontSize: AppTypography.sizeBodyMd,
                  fontWeight: AppTypography.medium,
                  color: selected
                      ? context.colors.primary
                      : context.colors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
