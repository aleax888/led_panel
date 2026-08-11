import 'package:flutter/material.dart';

import 'package:led_panel/presentation/widgets/animated_widget_list/fade_animation.dart';

class AnimatedWidgetList extends StatefulWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? itemPadding;
  final Duration duration;

  const AnimatedWidgetList({
    super.key,
    required this.children,
    this.itemPadding,
    this.duration = const Duration(milliseconds: 150),
  });

  @override
  State<AnimatedWidgetList> createState() => _AnimatedWidgetListState();
}

class _AnimatedWidgetListState extends State<AnimatedWidgetList> {
  late List<Widget> _items;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _items = List.of(widget.children);
  }

  @override
  void didUpdateWidget(covariant AnimatedWidgetList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncList(widget.children);
  }

  void _syncList(List<Widget> newChildren) {
    final newByKey = {for (final widget in newChildren) widget.key: widget};

    for (int i = _items.length - 1; i >= 0; i--) {
      final key = _items[i].key;
      if (!newByKey.containsKey(key)) {
        final removed = _items.removeAt(i);
        _listKey.currentState?.removeItem(
          i,
          (context, animation) =>
              FadeAnimation(animation: animation, child: removed),
          duration: widget.duration,
        );
      }
    }

    for (int i = 0; i < _items.length; i++) {
      final updated = newByKey[_items[i].key];
      if (updated != null) {
        _items[i] = updated;
      }
    }

    for (int i = 0; i < newChildren.length; i++) {
      final key = newChildren[i].key;
      final exists = _items.any((widget) => widget.key == key);
      if (!exists) {
        final index = i.clamp(0, _items.length);
        _items.insert(index, newChildren[i]);
        _listKey.currentState?.insertItem(index, duration: widget.duration);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) {
        return Padding(
          padding: widget.itemPadding ?? EdgeInsets.zero,
          child: FadeAnimation(animation: animation, child: _items[index]),
        );
      },
    );
  }
}
