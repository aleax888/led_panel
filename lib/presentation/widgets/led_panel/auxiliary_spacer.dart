import 'package:flutter/material.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

/// Adds horizontal spacing based on a provided or screen width.
class AuxiliarySpacer extends StatelessWidget {
  final double? space;
  const AuxiliarySpacer({super.key, this.space});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: space ?? context.screenSize.width);
  }
}
