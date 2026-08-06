import 'package:flutter/material.dart';
import 'package:led_panel/data/led_panel_config_model.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/theme/constants/app_typography.dart';

/// Un Widget que emula un panel LED de texto desplazante (marquee),
/// similar a los que se ven en negocios pequeños o buses de transporte.
///
/// La animación hace que el texto entre por la derecha y salga por la izquierda
/// de forma continua y sin cortes, calculando el ancho real del texto con
/// [TextPainter] para garantizar una ilusión perfectamente fluida.
class LedPanel extends StatefulWidget {
  /// Configuración completa del panel LED.
  final LedPanelConfigModel config;

  /// Alto del panel LED. Si es null, se ajusta al contenido más padding.
  final double? panelHeight;

  const LedPanel({super.key, required this.config, this.panelHeight});

  @override
  State<LedPanel> createState() => _LedPanelState();
}

class _LedPanelState extends State<LedPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scrollController;

  double _textWidth = 0.0;
  double _screenWidth = 0.0;

  double get _totalAnimationTravel => _screenWidth + _textWidth;

  Duration get _animationDuration {
    final double speed = widget.config.speed;
    if (speed <= 0 ||
        !_totalAnimationTravel.isFinite ||
        _totalAnimationTravel <= 0) {
      return const Duration(seconds: 10); // fallback seguro
    }
    final double ms = _totalAnimationTravel / speed * 1000;
    return Duration(milliseconds: ms.isFinite ? ms.round() : 10000);
  }

  double get _currentLeftPosition =>
      _screenWidth - (_scrollController.value * _totalAnimationTravel);

  @override
  void initState() {
    super.initState();
    _scrollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textWidth = _measureTextWidth();
    _screenWidth = context.screenSize.width;
    _scrollController.duration = _animationDuration;
  }

  @override
  void didUpdateWidget(covariant LedPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    _textWidth = _measureTextWidth();
    _scrollController.duration = _animationDuration;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        width: _screenWidth,
        height: widget.panelHeight,
        child: AnimatedBuilder(
          animation: _scrollController,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: [
                // Texto desplazante: el Positioned actualiza `left` en cada frame.
                Positioned(
                  left: _currentLeftPosition,
                  top: 0,
                  bottom: 0,
                  child: child!,
                ),
              ],
            );
          },
          child: SizedBox(
            width: _textWidth,
            child: OverflowBox(
              alignment: Alignment.center,
              minHeight: 0,
              maxHeight: double.infinity,
              child: Text(
                widget.config.text,
                maxLines: 1,
                style: _buildTextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Usa [TextPainter] para medir el ancho exacto (en píxeles lógicos) que
  /// ocupará [widget.text] con el estilo actualmente configurado.
  ///
  /// Es crítico que el [TextStyle] aquí sea idéntico al usado en el [Text]
  /// widget para que la medición coincida con el renderizado real.
  double _measureTextWidth() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: widget.config.text, style: _buildTextStyle()),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.width * 1.05;
  }

  /// Construye el [TextStyle] compartido entre [_measureTextWidth] y el
  /// [Text] widget para garantizar coherencia entre medición y renderizado.
  TextStyle _buildTextStyle() {
    return TextStyle(
      color: widget.config.color,
      fontSize: widget.config.fontSize,
      fontFamily: AppTypography.fontFamilyMono,
    );
  }
}
