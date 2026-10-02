import 'package:flutter/material.dart';
import 'package:led_panel/l10n/localization_extensions.dart';
import 'package:led_panel/data/enums/background_type_enum.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

/// Displays a selectable background option.
class BackgroundOption extends StatelessWidget {
  final BackgroundTypeEnum backgroundType;
  final bool selected;
  final VoidCallback? onTap;

  const BackgroundOption({
    super.key,
    required this.backgroundType,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: backgroundType.localizedLabel(context.locale),
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
          child: Icon(
            backgroundType.icon,
            size: AppSizes.iconMd,
            color: context.colors.onSurface,
          ),
        ),
      ),
    );
  }
}
