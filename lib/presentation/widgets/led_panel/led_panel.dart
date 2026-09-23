import 'package:flutter/material.dart';
import 'package:led_panel/data/models/animations/crawl_config_model.dart';
import 'package:led_panel/data/models/animations/marquee_config_model.dart';
import 'package:led_panel/data/models/animations/scramble_config_model.dart';
import 'package:led_panel/data/models/animations/typewriter_config_model.dart';
import 'package:led_panel/data/models/animations/wave_config_model.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/crawl_text.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/scramble_text.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/presentation/widgets/led_panel/dot_pattern.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/marquee_text.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/styled_text.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/typewriter_text.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/wave_text.dart';

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
              child: DotPattern(
                color: widget.config.background.ledsColor,
                shape: widget.config.background.ledsShape,
              ),
            ),

            // Effect ----------------------------------------------
            if (widget.config.animation.type == .none)
              StyledText(textConfig: widget.config.text)
            else if (widget.config.animation.type == .marquee)
              MarqueeText(
                textConfig: widget.config.text,
                animationConfig: widget.config.animation as MarqueeConfigModel,
                panelWidth: _panelWidth,
              )
            else if (widget.config.animation.type == .typewriter)
              TypewriterText(
                textConfig: widget.config.text,
                animationConfig:
                    widget.config.animation as TypewriterConfigModel,
              )
            else if (widget.config.animation.type == .wave)
              WaveText(
                textConfig: widget.config.text,
                animationConfig: widget.config.animation as WaveConfigModel,
              )
            else if (widget.config.animation.type == .scramble)
              ScrambleText(
                textConfig: widget.config.text,
                animationConfig: widget.config.animation as ScrambleConfigModel,
              )
            else if (widget.config.animation.type == .crawl)
              CrawlText(
                textConfig: widget.config.text,
                animationConfig: widget.config.animation as CrawlConfigModel,
              ),
          ],
        ),
      ),
    );
  }
}
