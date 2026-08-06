import 'package:flutter/material.dart';
import 'package:led_panel/extensions/context_extension.dart';

import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_typography.dart';

/// Opción de selección de familia tipográfica.
///
/// Renderiza un botón circular con el sample "Aa" usando la fuente dada.
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
              width: selected ? 2 : 1,
            ),
          ),
          alignment: .center,
          child: Text(
            'Aa',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: AppTypography.sizeHeadlineSm,
              fontWeight: AppTypography.semiBold,
              color: context.colors.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
