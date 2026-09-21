import 'package:flutter/material.dart';
import 'package:led_panel/data/enums/animation_type_enum.dart';

import 'package:led_panel/presentation/widgets/animation_selector/animation_option.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';

/// Displays a horizontal selector for animation types.
class AnimationSelector extends StatelessWidget {
  final AnimationTypeEnum selectedAnimation;
  final ValueChanged<AnimationTypeEnum>? onChanged;

  const AnimationSelector({
    super.key,
    required this.selectedAnimation,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputLabel(
      label: 'ANIMATION',
      child: SizedBox(
        height: AppSizes.avatarLg,
        child: ListView.separated(
          scrollDirection: .horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          itemCount: AnimationTypeEnum.values.length,
          separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (context, index) {
            final AnimationTypeEnum animationType =
                AnimationTypeEnum.values[index];
            return AnimationOption(
              animationType: animationType,
              selected: animationType == selectedAnimation,
              onTap: onChanged == null ? null : () => onChanged!(animationType),
            );
          },
        ),
      ),
    );
  }
}
