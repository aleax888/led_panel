import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

class SeparatedListTab extends StatelessWidget {
  final List<Widget> children;
  const SeparatedListTab({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: AppSpacing.screenPadding,
      itemCount: children.length,
      separatorBuilder: (context, index) => Divider(height: AppSpacing.xxl),
      itemBuilder: (context, index) => children[index],
    );
  }
}
