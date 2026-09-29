import 'package:flutter/material.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/presentation/widgets/led_panel/dot_pattern.dart';

/// Displays an animated scrolling LED text panel.
class LedPanel extends StatefulWidget {
  final double? panelHeight;
  final double? panelWidth;
  final BorderRadius? borderRadius;
  final LedPanelConfigModel config;

  const LedPanel({
    super.key,
    this.panelHeight,
    this.panelWidth,
    this.borderRadius,
    required this.config,
  });

  @override
  State<LedPanel> createState() => _LedPanelState();
}

class _LedPanelState extends State<LedPanel> {
  double get _panelHeight => widget.panelHeight ?? context.screenSize.height;
  double get _panelWidth => widget.panelWidth ?? context.screenSize.width;

  @override
  Widget build(BuildContext context) {
    // Main LED panel UI ----------------------------------------------
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(0.0),
      child: Container(
        width: _panelWidth,
        height: _panelHeight,
        decoration: BoxDecoration(
          // color: widget.config.background.color,
          borderRadius: widget.borderRadius,
        ),
        child: Stack(
          alignment: .center,
          clipBehavior: .hardEdge,
          children: [
            // Background ----------------------------------------------
            Positioned.fill(
              child: widget.config.background.type.renderer.build(
                widget.config.background,
              ),
            ),

            // Leds ----------------------------------------------
            RepaintBoundary(child: DotPattern(config: widget.config.leds)),

            // Animation ----------------------------------------------
            widget.config.animation.type.renderer.build(
              widget.config.text,
              widget.config.animation,
              _panelWidth,
              _panelHeight,
            ),
          ],
        ),
      ),
    );
  }
}
