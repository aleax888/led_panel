import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:led_panel/data/enums/marquee_text_direction_enum.dart';
import 'package:led_panel/data/models/animations/marquee_config_model.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/auxiliary_spacer.dart';
import 'package:led_panel/presentation/widgets/led_panel/text.dart';

/// Displays an animated scrolling LED text panel.
class MarqueeText extends StatefulWidget {
  final TextConfigModel textConfig;
  final MarqueeConfigModel config;
  final double panelWidth;

  const MarqueeText({
    super.key,
    required this.textConfig,
    required this.config,
    required this.panelWidth,
  });

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
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
  void didUpdateWidget(covariant MarqueeText oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool layoutMayHaveChanged =
        oldWidget.textConfig.message != widget.textConfig.message ||
        oldWidget.textConfig.fontSize != widget.textConfig.fontSize ||
        oldWidget.textConfig.fontFamily != widget.textConfig.fontFamily ||
        oldWidget.panelWidth != widget.panelWidth;

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
    // Animated text ----------------------------------------------
    return OverflowBox(
      minWidth: 0,
      maxWidth: double.infinity,
      minHeight: 0,
      maxHeight: double.infinity,
      alignment: widget.config.direction.alignment,
      child: ValueListenableBuilder<double>(
        valueListenable: _offset,
        builder: (context, offset, child) {
          // print('Offset: ${offset.toString().padRight(30)}, MaxOffset: $_maxOffset');
          return Transform.translate(
            offset: Offset(offset * widget.config.direction.multiplier, 0),
            child: child,
          );
        },
        child: Row(
          key: _contentKey,
          mainAxisSize: .min,
          crossAxisAlignment: .center,
          children: [
            // Spacer (animation logic) ----------------------------------------------
            AuxiliarySpacer(space: widget.panelWidth),

            // Led text ----------------------------------------------
            StyledText(textConfig: widget.textConfig),

            // Spacer (animation logic) ----------------------------------------------
            AuxiliarySpacer(space: widget.panelWidth),
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
      final double rawMax = renderBox.size.width - widget.panelWidth;
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
