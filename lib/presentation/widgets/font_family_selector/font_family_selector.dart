import 'package:flutter/material.dart';

import 'package:led_panel/presentation/widgets/font_family_selector/font_family_option.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_typography.dart';

/// Selector horizontal de familias tipográficas.
///
/// Muestra las familias registradas en [AppTypography] y expone un callback
/// cuando el usuario selecciona una opción.
class FontFamilySelector extends StatelessWidget {
  final String selectedFontFamily;
  final ValueChanged<String>? onChanged;

  const FontFamilySelector({
    super.key,
    required this.selectedFontFamily,
    this.onChanged,
  });

  static const List<String> _fontFamilies = [
    AppTypography.fontRoboto,
    AppTypography.fontIntelOneMono,
    AppTypography.fontInter,
    AppTypography.fontIrishGrover,
    AppTypography.fontItalianno,
    AppTypography.fontKarantina,
    AppTypography.fontPixelifySans,
    AppTypography.fontPoppins,
  ];

  @override
  Widget build(BuildContext context) {
    return InputLabel(
      label: 'FUENTE',
      child: SizedBox(
        height: AppSizes.avatarLg,
        child: ListView.separated(
          scrollDirection: .horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          itemCount: _fontFamilies.length,
          separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (context, index) {
            final String fontFamily = _fontFamilies[index];
            return FontFamilyOption(
              fontFamily: fontFamily,
              selected: fontFamily == selectedFontFamily,
              onTap: onChanged == null ? null : () => onChanged!(fontFamily),
            );
          },
        ),
      ),
    );
  }
}
