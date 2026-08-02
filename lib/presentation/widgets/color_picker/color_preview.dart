import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_opacity.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';

/// Vista previa cuadrada del color actual, con un leve resplandor
/// del mismo color para reforzar la retroalimentación visual.
class ColorPreview extends StatelessWidget {
  final Color color;

  const ColorPreview({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    final Color borderColor = Theme.of(context).colorScheme.outline;

    return Container(
      width: AppSizes.colorSwatchMd,
      height: AppSizes.colorSwatchMd,
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppRadius.borderRadiusXs,
        border: Border.all(
          color: borderColor,
          width: AppSizes.borderWidthThick,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(AppOpacity.glow),
            blurRadius: AppSizes.glowBlurRadius,
          ),
        ],
      ),
    );
  }
}
