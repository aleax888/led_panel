import 'package:flutter/material.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

class PanelSizehandler {
  const PanelSizehandler._();

  static FixedDimensions getFixedDimensions(
    BuildContext context, [
    EdgeInsets padding = EdgeInsets.zero,
    double relation = 1,
  ]) {
    final screenWidth = context.screenSize.width;
    final screenHeight = context.screenSize.height;

    final fixedPanelWidth = (screenWidth - padding.horizontal) / relation;
    final fixedPanelHeight = (fixedPanelWidth * screenWidth) / screenHeight;
    final proportion = fixedPanelWidth / screenHeight;

    return FixedDimensions(
      width: fixedPanelWidth,
      height: fixedPanelHeight,
      proportion: proportion,
    );
  }
}

class FixedDimensions {
  final double width;
  final double height;
  final double proportion;

  const FixedDimensions({
    required this.width,
    required this.height,
    required this.proportion,
  });
}
