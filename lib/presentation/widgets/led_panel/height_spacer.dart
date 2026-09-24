import 'package:flutter/material.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

/// Adds vertical spacing based on a provided or screen height.
class HeightSpacer extends StatelessWidget {
  final double? space;
  const HeightSpacer({super.key, this.space});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: space ?? context.screenSize.height);
  }
}
