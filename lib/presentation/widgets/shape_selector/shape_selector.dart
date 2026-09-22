import 'package:flutter/material.dart';
import 'package:led_panel/data/enums/dot_shape_enum.dart';

import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/presentation/widgets/shape_selector/shape_option.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';

/// Displays a horizontal selector for shapes.
class ShapeSelector extends StatelessWidget {
  final DotShapeEnum selectedShape;
  final ValueChanged<DotShapeEnum>? onChanged;

  const ShapeSelector({
    super.key,
    required this.selectedShape,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputLabel(
      label: 'LEDs SHAPE',
      child: SizedBox(
        height: AppSizes.avatarLg,
        child: ListView.separated(
          scrollDirection: .horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          itemCount: DotShapeEnum.values.length,
          separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (context, index) {
            final DotShapeEnum shape =
                DotShapeEnum.values[index];
            return ShapeOption(
              animationType: shape,
              selected: shape == selectedShape,
              onTap: onChanged == null ? null : () => onChanged!(shape),
            );
          },
        ),
      ),
    );
  }
}
