import 'package:flutter/material.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';

/// Vista previa cuadrada del color actual
class ColorPreview extends StatelessWidget {
  final Color color;
  const ColorPreview({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.colorSwatchMd,
      height: AppSizes.colorSwatchMd,
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppRadius.borderRadiusXs,
        border: Border.all(
          color: context.colors.outline,
          width: AppSizes.borderWidthThick,
        ),
      ),
    );
  }
}
