import 'package:flutter/material.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

import 'package:led_panel/theme/constants/app_sizes.dart';

/// Displays a selectable font family option.
class FontFamilyOption extends StatelessWidget {
  final String fontFamily;
  final bool selected;
  final VoidCallback? onTap;

  const FontFamilyOption({
    super.key,
    required this.fontFamily,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: fontFamily,
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
          alignment: .center,
          // Short text to show the font aspect ----------------------------------------------
          child: Text(
            'Aa',
            style: context.textTheme.headlineLarge?.copyWith(
              fontFamily: fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
