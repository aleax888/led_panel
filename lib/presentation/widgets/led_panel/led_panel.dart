import 'package:flutter/material.dart';
import 'package:led_panel/data/models/animations/marquee_config_model.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/presentation/widgets/led_panel/dot_pattern.dart';
import 'package:led_panel/presentation/widgets/led_panel/marquee_text.dart';
import 'package:led_panel/presentation/widgets/led_panel/text.dart';

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
          color: widget.config.background.color,
          borderRadius: widget.borderRadius,
        ),
        child: Stack(
          alignment: .center,
          clipBehavior: .hardEdge,
          children: [
            // Dot pattern ----------------------------------------------
            RepaintBoundary(
              child: DotPattern(color: widget.config.background.ledsColor),
            ),

            // Effect ----------------------------------------------
            if (widget.config.animation.type == .marquee)
              MarqueeText(
                textConfig: widget.config.text,
                config: widget.config.animation as MarqueeConfigModel,
                panelWidth: _panelWidth,
              )
            else if (widget.config.animation.type == .none)
              StyledText(textConfig: widget.config.text)
            else
              Container(),
          ],
        ),
      ),
    );
  }
}
