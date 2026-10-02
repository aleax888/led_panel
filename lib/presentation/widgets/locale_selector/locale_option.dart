import 'package:flutter/material.dart';
import 'package:led_panel/l10n/localization_extensions.dart';
import 'package:led_panel/data/enums/locale_enum.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
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
          child: Center(
            child: Text(label, style: context.textTheme.labelLarge),
          ),
        ),
      ),
    );
  }
}
