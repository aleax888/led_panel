import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

class ScrollableTab extends StatelessWidget {
  final List<Widget> children;
  const ScrollableTab({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        spacing: AppSpacing.md,
        crossAxisAlignment: .stretch,
        children: children,
      ),
    );
  }
}
