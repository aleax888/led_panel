import 'package:flutter/material.dart';
import 'package:led_panel/data/enums/locale_enum.dart';
import 'package:led_panel/presentation/widgets/locale_selector/locale_option.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Displays a horizontal selector for supported locales.
class LocaleSelector extends StatelessWidget {
  final LocaleEnum selectedLocale;
  final ValueChanged<LocaleEnum>? onChanged;

  const LocaleSelector({
    super.key,
    required this.selectedLocale,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.avatarLg,
      child: ListView.separated(
        scrollDirection: .horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: AppSpacing.sm),
        itemCount: LocaleEnum.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final LocaleEnum locale = LocaleEnum.values[index];
          return LocaleOption(
            locale: locale,
            selected: locale == selectedLocale,
            onTap: onChanged == null ? null : () => onChanged!(locale),
          );
        },
      ),
    );
  }
}
