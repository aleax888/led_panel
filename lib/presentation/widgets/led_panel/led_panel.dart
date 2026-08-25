import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:led_panel/data/led_panel_config_model.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/presentation/widgets/led_panel/auxiliary_spacer.dart';
import 'package:led_panel/presentation/widgets/led_panel/dot_pattern.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel_direction_enum.dart';

/// Displays an animated scrolling LED text panel.
class LedPanel extends StatefulWidget {
  final LedPanelConfigModel config;
  final double? panelHeight;
  final double? panelWidth;
  final BorderRadius? borderRadius;

  const LedPanel({
    super.key,
    required this.config,
    this.panelHeight,
    this.panelWidth,
    this.borderRadius,
  });

  @override
  State<LedPanel> createState() => _LedPanelState();
}

class _LedPanelState extends State<LedPanel>
    with SingleTickerProviderStateMixin {
  /// Key for reading the calculated width of the content row.
  final GlobalKey _contentKey = GlobalKey();

  /// Current horizontal offset magnitude. The applied sign depends on the
  /// panel direction.
  final ValueNotifier<double> _offset = ValueNotifier<double>(0.0);

  late final Ticker _ticker;
  Duration _lastElapsed = Duration.zero;

  /// Total scrollable width.
  double _maxOffset = 0.0;

  double get _panelHeight => widget.panelHeight ?? context.screenSize.height;
  double get _panelWidth => widget.panelWidth ?? context.screenSize.width;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    _scheduleMaxOffsetUpdate();
    _ticker.start();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scheduleMaxOffsetUpdate();
  }

  @override
  void didUpdateWidget(covariant LedPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool layoutMayHaveChanged =
        oldWidget.config.text != widget.config.text ||
        oldWidget.config.fontSize != widget.config.fontSize ||
        oldWidget.config.fontFamily != widget.config.fontFamily;

    if (layoutMayHaveChanged) {
      _scheduleMaxOffsetUpdate();
    }

    if (oldWidget.config.direction != widget.config.direction) {
      _offset.value = _maxOffset - _offset.value;
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _offset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Main LED panel UI ----------------------------------------------
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(0.0),
      child: Container(
        width: _panelWidth,
        height: _panelHeight,
        decoration: BoxDecoration(
          color: widget.config.backgroundColor,
          borderRadius: widget.borderRadius,
        ),
        child: Stack(
          alignment: .center,
          clipBehavior: .hardEdge,
          children: [
            // Dot pattern ----------------------------------------------
            DotPattern(color: widget.config.ledsColor),

            // Animated text ----------------------------------------------
            OverflowBox(
              minWidth: 0,
              maxWidth: double.infinity,
              minHeight: 0,
              maxHeight: double.infinity,
              alignment: widget.config.direction.alignment,
              child: ValueListenableBuilder<double>(
                valueListenable: _offset,
                builder: (context, offset, child) {
                  return Transform.translate(
                    offset: Offset(
                      offset * widget.config.direction.multiplier,
                      0,
                    ),
                    child: child,
                  );
                },
                child: Row(
                  key: _contentKey,
                  mainAxisSize: .min,
                  crossAxisAlignment: .center,
                  children: [
                    // Spacer (animation logic) ----------------------------------------------
                    AuxiliarySpacer(space: _panelWidth),

                    // Led text ----------------------------------------------
                    Text(
                      widget.config.text,
                      maxLines: 1,
                      style: TextStyle(
                        color: widget.config.textColor,
                        fontSize: widget.config.fontSize,
                        fontFamily: widget.config.fontFamily,
                        letterSpacing: widget.config.letterSpacing,
                        wordSpacing: widget.config.wordSpacing,
                        shadows: [
                          Shadow(
                            color: widget.config.textColor,
                            blurRadius: widget.config.glowRadius,
                          ),
                        ],
                      ),
                      textAlign: .center,
                    ),

                    // Spacer (animation logic) ----------------------------------------------
                    AuxiliarySpacer(space: _panelWidth),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Waits for layout to finish, then refreshes [_maxOffset] using the row's
  /// calculated width from [_contentKey].
  void _scheduleMaxOffsetUpdate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final renderBox =
          _contentKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) return;
      final double rawMax = renderBox.size.width - _panelWidth;
      _maxOffset = rawMax > 0 ? rawMax : 0;
    });
  }

  void _onTick(Duration elapsed) {
    final double deltaSeconds =
        (elapsed - _lastElapsed).inMicroseconds /
        Duration.microsecondsPerSecond;
    _lastElapsed = elapsed;

    if (_maxOffset <= 0 || widget.config.speed <= 0) return;

    final double nextOffset =
        _offset.value + widget.config.speed * deltaSeconds;

    _offset.value = nextOffset >= _maxOffset
        ? nextOffset % _maxOffset
        : nextOffset;
  }
}
