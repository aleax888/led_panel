import 'package:flutter/material.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Displays a reusable bar for selecting between multiple tabs.
class MultiTabsBar extends StatelessWidget {
  final TabController controller;
  final List<String> tabNames;
  final ValueChanged<int>? onTap;

  const MultiTabsBar({
    super.key,
    required this.controller,
    required this.tabNames,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(
          color: context.colors.outline,
          width: AppSizes.borderWidthThin,
        ),
        borderRadius: AppRadius.borderRadiusLg,
      ),
      child: TabBar(
        controller: controller,
        onTap: onTap,
        isScrollable: tabNames.length > 3,
        labelPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        splashBorderRadius: AppRadius.borderRadiusLg,
        indicatorPadding: const EdgeInsets.all(-3),
        tabs: tabNames
            .map(
              (name) =>
                  Tab(child: Text(name.toUpperCase(), textAlign: .center)),
            )
            .toList(),
      ),
    );
  }
}
