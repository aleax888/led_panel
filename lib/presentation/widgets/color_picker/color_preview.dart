import 'package:flutter/material.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/presentation/widgets/color_picker/rainbow_angular_gradient.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Displays the selected color with a rainbow picker indicator.
class ColorPreview extends StatelessWidget {
  final Color color;
  const ColorPreview({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.avatarMd,
      height: AppSizes.avatarMd,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppRadius.borderRadiusSm,
        border: Border.all(
          color: Color.lerp(color, context.colors.onSurface, 0.1) ?? color,
          width: AppSizes.borderWidthThin,
        ),
      ),
      child: RainbowAngularGradient(),
    );
  }
}
