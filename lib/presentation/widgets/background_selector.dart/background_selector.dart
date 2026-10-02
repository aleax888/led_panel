import 'package:flutter/material.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/data/enums/background_type_enum.dart';
import 'package:led_panel/presentation/widgets/background_selector.dart/background_option.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Displays a horizontal selector for background types.
class BackgroundSelector extends StatelessWidget {
  final BackgroundTypeEnum selectedBackground;
  final ValueChanged<BackgroundTypeEnum>? onChanged;

  const BackgroundSelector({
    super.key,
    required this.selectedBackground,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputLabel(
      label: context.locale.background,
      child: SizedBox(
        height: AppSizes.avatarLg,
        child: ListView.separated(
          scrollDirection: .horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          itemCount: BackgroundTypeEnum.values.length,
          separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (context, index) {
            final BackgroundTypeEnum backgroundType =
                BackgroundTypeEnum.values[index];
            return BackgroundOption(
              backgroundType: backgroundType,
              selected: backgroundType == selectedBackground,
              onTap: onChanged == null
                  ? null
                  : () => onChanged!(backgroundType),
            );
          },
        ),
      ),
    );
  }
}
