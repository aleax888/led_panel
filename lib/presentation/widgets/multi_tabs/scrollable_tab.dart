import 'package:flutter/material.dart';

import 'package:led_panel/presentation/widgets/animated_widget_list/animated_widget_list.dart';
import 'package:led_panel/presentation/widgets/no_content_feedback.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

class ScrollableTab extends StatelessWidget {
  final List<Widget> children;

  const ScrollableTab({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return children.isEmpty
        ? const NoContentFeedback()
        : AnimatedWidgetList(
            itemPadding: const EdgeInsets.only(bottom: AppSpacing.md),
            children: children,
          );
  }
}
