import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:led_panel/data/led_panel_config_model.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/presentation/widgets/led_panel/auxiliary_spacer.dart';
import 'package:led_panel/presentation/widgets/led_panel/dot_pattern.dart';

/// Un Widget que emula un panel LED de texto desplazante (marquee).
///
/// La animación se logra trasladando (`Transform.translate`) un [Row]
/// compuesto por [AuxiliarySpacer] + texto + [AuxiliarySpacer] (cada
/// spacer con el ancho exacto de la pantalla), en vez de usar un
/// [ScrollController]/[SingleChildScrollView]: eso permite que el [Row]
/// se layoutee a su tamaño REAL (vía [OverflowBox]) sin que el alto fijo
/// del panel lo comprima — un [Viewport] de scroll necesita alto acotado,
/// un [Row] suelto no.
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
  /// Key sobre la fila de contenido, para leer su ancho real ya calculado.
  final GlobalKey _contentKey = GlobalKey();

  /// Offset horizontal actual.
  final ValueNotifier<double> _offset = ValueNotifier<double>(0.0);

  late final Ticker _ticker;
  Duration _lastElapsed = Duration.zero;

  /// Ancho total desplazable.
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
  }

  @override
  void dispose() {
    _ticker.dispose();
    _offset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            DotPattern(color: widget.config.ledsColor),
            OverflowBox(
              minWidth: 0,
              maxWidth: double.infinity,
              minHeight: 0,
              maxHeight: double.infinity,
              alignment: const Alignment(-1, 0),
              child: ValueListenableBuilder<double>(
                valueListenable: _offset,
                builder: (context, offset, child) {
                  return Transform.translate(
                    offset: Offset(-offset, 0),
                    child: child,
                  );
                },
                child: Row(
                  key: _contentKey,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AuxiliarySpacer(),
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
                      textAlign: TextAlign.center,
                    ),
                    const AuxiliarySpacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Espera a que el frame actual termine su fase de layout y refresca
  /// [_maxOffset] leyendo el ancho real de la fila vía [_contentKey].
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
