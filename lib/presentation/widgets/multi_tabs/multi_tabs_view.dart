import 'package:flutter/material.dart';

import 'package:led_panel/presentation/widgets/multi_tabs/multi_tabs_bar.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Displays multiple tabs and their corresponding content views.
class MultiTabsView extends StatefulWidget {
  final List<String> tabNames;
  final List<Widget> tabViews;
  final TabController? controller;
  final ValueChanged<int>? onTabChanged;
  final EdgeInsetsGeometry? padding;

  const MultiTabsView({
    super.key,
    required this.tabNames,
    required this.tabViews,
    this.controller,
    this.onTabChanged,
    this.padding,
  }) : assert(
         tabNames.length == tabViews.length,
         'tabNames and tabViews must have the same length',
       );

  @override
  State<MultiTabsView> createState() => _MultiTabsViewState();
}

class _MultiTabsViewState extends State<MultiTabsView>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  late bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller =
        widget.controller ??
        TabController(length: widget.tabNames.length, vsync: this);
  }

  @override
  void didUpdateWidget(covariant MultiTabsView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      if (_ownsController && oldWidget.controller == null) {
        _controller.dispose();
      }

      _ownsController = widget.controller == null;
      _controller =
          widget.controller ??
          TabController(length: widget.tabNames.length, vsync: this);
    }
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.lg,
      children: [
        // Tab bar ----------------------------------------------
        MultiTabsBar(
          controller: _controller,
          tabNames: widget.tabNames,
          onTap: widget.onTabChanged,
        ),

        // Tab views ----------------------------------------------
        Expanded(
          child: Container(
            padding: widget.padding,
            child: TabBarView(
              controller: _controller,
              children: widget.tabViews,
            ),
          ),
        ),
      ],
    );
  }
}
