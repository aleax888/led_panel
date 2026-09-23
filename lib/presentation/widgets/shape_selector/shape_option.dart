import 'package:flutter/material.dart';
import 'package:led_panel/data/enums/dot_shape_enum.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

import 'package:led_panel/theme/constants/app_sizes.dart';

/// Displays a selectable shape option.
class ShapeOption extends StatelessWidget {
  final DotShapeEnum animationType;
  final bool selected;
  final VoidCallback? onTap;

  const ShapeOption({
    super.key,
    required this.animationType,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: animationType.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.avatarLg),
        child: Container(
          width: AppSizes.avatarLg,
          height: AppSizes.avatarLg,
          decoration: BoxDecoration(
            color: context.colors.surface,
            shape: .circle,
            border: Border.all(
              color: selected ? context.colors.primary : context.colors.outline,
              width: selected
                  ? AppSizes.borderWidthThick
                  : AppSizes.borderWidthThin,
            ),
          ),
          clipBehavior: .antiAlias,
          child: Image.asset(
            animationType.asset,
            fit: .cover,
            errorBuilder: (_, _, _) => Icon(
              Icons.animation,
              size: AppSizes.iconMd,
              color: context.colors.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
