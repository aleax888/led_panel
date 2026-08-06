import 'package:flutter/material.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';

class ColorOption extends StatelessWidget {
  final Color color;
  final VoidCallback? onTap;
  const ColorOption({super.key, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: AppSizes.avatarMd,
        height: AppSizes.avatarMd,
        decoration: BoxDecoration(
          color: color,
          borderRadius: AppRadius.borderRadiusSm,
          border: Border.all(
            color: Color.lerp(color, context.colors.onSurface, 0.1) ?? color,
            width: AppSizes.borderWidthThin,
          ),
        ),
      ),
    );
  }
}
