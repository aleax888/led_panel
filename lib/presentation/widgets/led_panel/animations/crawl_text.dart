import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:led_panel/data/models/animations/crawl_config_model.dart';
import 'package:led_panel/data/models/led_panel/text_config_model.dart';
import 'package:led_panel/presentation/widgets/led_panel/animations/styled_text.dart';
import 'package:led_panel/presentation/widgets/led_panel/height_spacer.dart';

class CrawlText extends StatefulWidget {
  final TextConfigModel textConfig;
  final CrawlConfigModel animationConfig;
  final double panelWidth;
  final double panelHeight;

  const CrawlText({
    super.key,
    required this.textConfig,
    required this.animationConfig,
    required this.panelWidth,
    required this.panelHeight,
  });

  @override
  State<CrawlText> createState() => _CrawlTextState();
}

class _CrawlTextState extends State<CrawlText>
    with SingleTickerProviderStateMixin {
  /// Key for reading the calculated height of the content column.
  final GlobalKey _contentKey = GlobalKey();

  /// Current vertical offset magnitude (pre-proyección).
  final ValueNotifier<double> _offset = ValueNotifier<double>(0.0);

  late final Ticker _ticker;
  Duration _lastElapsed = Duration.zero;

  /// Total scrollable height.
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
  void didUpdateWidget(covariant CrawlText oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool layoutMayHaveChanged =
        oldWidget.textConfig.message != widget.textConfig.message ||
        oldWidget.textConfig.fontSize != widget.textConfig.fontSize ||
        oldWidget.textConfig.fontFamily != widget.textConfig.fontFamily ||
        oldWidget.panelWidth != widget.panelWidth ||
        oldWidget.panelHeight != widget.panelHeight ||
        oldWidget.animationConfig.tilt != widget.animationConfig.tilt ||
        oldWidget.animationConfig.perspective !=
            widget.animationConfig.perspective;

    if (layoutMayHaveChanged) {
      _scheduleMaxOffsetUpdate();
    }

    if (oldWidget.animationConfig.direction !=
        widget.animationConfig.direction) {
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
    return OverflowBox(
      minWidth: 0,
      maxWidth: widget.panelWidth,
      minHeight: 0,
      maxHeight: double.infinity,
      alignment: widget.animationConfig.direction.alignment,
      child: ValueListenableBuilder<double>(
        valueListenable: _offset,
        builder: (context, offset, child) {
          return Transform(
            alignment: widget.animationConfig.direction.alignment,
            transform: Matrix4.identity()
              ..setEntry(3, 2, widget.animationConfig.perspective)
              ..rotateX(
                widget.animationConfig.tilt *
                    -widget.animationConfig.direction.multiplier,
              )
              ..translateByDouble(
                0.0,
                offset * widget.animationConfig.direction.multiplier,
                0.0,
                1.0,
              ),
            child: child,
          );
        },
        child: Column(
          key: _contentKey,
          crossAxisAlignment: .center,
          children: [
            // Spacer (animation logic) ----------------------------------------------
            HeightSpacer(space: widget.panelHeight),

            // Led text ----------------------------------------------
            StyledText(textConfig: widget.textConfig, maxLines: null),

            // Spacer (animation logic) ----------------------------------------------
            HeightSpacer(space: widget.panelHeight),
          ],
        ),
      ),
    );
  }

  /// Waits for layout to finish, then refreshes [_maxOffset] using the
  /// column's calculated height from [_contentKey].
  void _scheduleMaxOffsetUpdate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final renderBox =
          _contentKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) return;
      final double rawMax = renderBox.size.height - widget.panelHeight;
      _maxOffset = rawMax > 0 ? rawMax : 0;
    });
  }

  void _onTick(Duration elapsed) {
    final double deltaSeconds =
        (elapsed - _lastElapsed).inMicroseconds /
        Duration.microsecondsPerSecond;
    _lastElapsed = elapsed;

    if (_maxOffset <= 0 || widget.animationConfig.speed <= 0) return;

    final double nextOffset =
        _offset.value + widget.animationConfig.speed * deltaSeconds;

    _offset.value = nextOffset >= _maxOffset
        ? nextOffset % _maxOffset
        : nextOffset;
  }
}
