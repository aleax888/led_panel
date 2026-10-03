import 'package:flutter/material.dart';
import 'package:led_panel/utils/extensions/localization_extensions.dart';
import 'package:led_panel/data/enums/locale_enum.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

/// Displays a selectable locale option.
class LocaleOption extends StatelessWidget {
  final LocaleEnum locale;
  final bool selected;
  final VoidCallback? onTap;

  const LocaleOption({
    super.key,
    required this.locale,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String label = locale.localizedLabel(context.locale);

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.borderRadiusLg,
        child: Container(
          padding: AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border.all(
              color: selected ? context.colors.primary : context.colors.outline,
              width: selected
                  ? AppSizes.borderWidthThick
                  : AppSizes.borderWidthThin,
            ),
            borderRadius: AppRadius.borderRadiusLg
          ),
          child: Center(
            child: Text(label, style: context.textTheme.labelLarge),
          ),
        ),
      ),
    );
  }
}
