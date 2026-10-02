import 'package:flutter/material.dart';
import 'package:led_panel/data/enums/crawl_direction_enum.dart';
import 'package:led_panel/data/enums/marquee_direction_enum.dart';
import 'package:led_panel/l10n/app_localizations.dart';
import 'package:led_panel/l10n/localization_extensions.dart';
import 'package:led_panel/presentation/widgets/direction_selector/direction_selector_option.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

/// Displays a horizontal selector for the text scrolling direction.
class DirectionSelector<T> extends StatelessWidget {
  final List<T> options;
  final T selectedDirection;
  final ValueChanged<T>? onChanged;

  const DirectionSelector({
    super.key,
    required this.options,
    required this.selectedDirection,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputLabel(
      label: context.locale.direction,
      child: SizedBox(
        height: AppSizes.avatarMd,
        child: Row(
          spacing: AppSpacing.md,
          children: [
            // Options ----------------------------------------------
            ...options.map(
              (e) => Expanded(
                child: DirectionSelectorOption(
                  label: _localizedLabel(e, context.locale),
                  icon: _icon(e),
                  selected: e == selectedDirection,
                  onTap: () => onChanged?.call(e),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _localizedLabel(T value, AppLocalizations l10n) => switch (value) {
    final CrawlTextDirectionEnum direction => direction.localizedLabel(l10n),
    final MarqueeDirectionEnum direction => direction.localizedLabel(l10n),
    _ => throw UnsupportedError('Unsupported direction option: $value'),
  };

  IconData _icon(T value) => switch (value) {
    final CrawlTextDirectionEnum direction => direction.icon,
    final MarqueeDirectionEnum direction => direction.icon,
    _ => throw UnsupportedError('Unsupported direction option: $value'),
  };
}
