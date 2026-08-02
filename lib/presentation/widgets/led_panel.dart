import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_typography.dart';

/// Un Widget que emula un panel LED de texto desplazante (marquee),
/// similar a los que se ven en negocios pequeños o buses de transporte.
///
/// La animación hace que el texto entre por la derecha y salga por la izquierda
/// de forma continua y sin cortes, calculando el ancho real del texto con
/// [TextPainter] para garantizar una ilusión perfectamente fluida.
class LedPanel extends StatefulWidget {
  /// El texto que se mostrará desplazándose en el panel.
  final String text;

  /// Velocidad del desplazamiento en píxeles por segundo.
  /// Valores mayores = animación más rápida.
  final double scrollSpeedPixelsPerSecond;

  /// Color de fondo del panel (el "chasis" LED).
  final Color panelBackgroundColor;

  /// Color del texto luminoso del panel.
  final Color ledTextColor;

  /// Color del "halo" o resplandor que simula la luminosidad LED.
  /// Si es null, se deriva de [ledTextColor] automáticamente.
  final Color? ledGlowColor;

  /// Tamaño de la fuente del texto LED.
  final double fontSize;

  /// Familia tipográfica. Se recomienda una monoespaciada para mayor realismo.
  final String fontFamily;

  /// Peso de la fuente.
  final FontWeight fontWeight;

  /// Alto del panel LED. Si es null, se ajusta al contenido más padding.
  final double? panelHeight;

  const LedPanel({
    super.key,
    required this.text,
    this.scrollSpeedPixelsPerSecond = 80.0,
    this.panelBackgroundColor = Colors.black,
    this.ledTextColor = AppColors.onPrimary,
    this.ledGlowColor,
    this.fontSize = AppTypography.sizeBodyLg,
    this.fontFamily = AppTypography.fontFamilyMono,
    this.fontWeight = AppTypography.bold,
    this.panelHeight,
  });

  @override
  State<LedPanel> createState() => _LedPanelState();
}

class _LedPanelState extends State<LedPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _scrollController;

  /// Bandera que evita que [didChangeDependencies] intente actualizar el
  /// controller antes de que haya sido creado en la primera llamada.
  bool _isControllerInitialized = false;

  /// Ancho calculado del texto con [TextPainter], en píxeles.
  double _textWidth = 0.0;

  /// Ancho de la pantalla obtenido con [MediaQuery].
  double _screenWidth = 0.0;

  /// El recorrido total de la animación:
  /// desde que el texto entra por la derecha hasta que desaparece por la izquierda.
  /// totalTravel = screenWidth + textWidth
  double get _totalAnimationTravel => _screenWidth + _textWidth;

  /// Duración calculada a partir de la distancia total y la velocidad deseada.
  Duration get _animationDuration => Duration(
    milliseconds:
        (_totalAnimationTravel / widget.scrollSpeedPixelsPerSecond * 1000)
            .round(),
  );

  /// Posición `left` actual del texto dentro del Stack.
  ///
  /// El valor va de [_screenWidth] (texto invisible, entrando por la derecha)
  /// hasta [-_textWidth] (texto invisible, saliendo por la izquierda).
  /// El recorrido cubre [_totalAnimationTravel] píxeles en total.
  double get _currentLeftPosition =>
      _screenWidth - (_scrollController.value * _totalAnimationTravel);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final double newScreenWidth = MediaQuery.sizeOf(context).width;

    if (newScreenWidth == _screenWidth) return; // Sin cambio real, ignorar.

    _screenWidth = newScreenWidth;

    if (!_isControllerInitialized) {
      // Primera llamada: crear el controller por única vez.
      _textWidth = _measureTextWidth();
      _scrollController = AnimationController(
        vsync: this,
        duration: _animationDuration,
      )..repeat();
      _isControllerInitialized = true;
    } else {
      // El ancho de pantalla cambió (ej. rotación): actualizar en caliente.
      _applyHotUpdate(remeasureText: false);
    }
  }

  @override
  void didUpdateWidget(covariant LedPanel oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Detectamos qué cambió para decidir si hay que volver a medir el texto.
    // NUNCA recreamos el AnimationController: solo actualizamos su `duration`
    // y preservamos el `value` actual para que la animación no salte.
    final bool affectsTextWidth =
        oldWidget.text != widget.text ||
        oldWidget.fontSize != widget.fontSize ||
        oldWidget.fontFamily != widget.fontFamily ||
        oldWidget.fontWeight != widget.fontWeight;

    final bool affectsSpeedOnly =
        !affectsTextWidth &&
        oldWidget.scrollSpeedPixelsPerSecond !=
            widget.scrollSpeedPixelsPerSecond;

    if (affectsTextWidth || affectsSpeedOnly) {
      _applyHotUpdate(remeasureText: affectsTextWidth);
    }
    // Cambios de color, glow, borderRadius, etc. no requieren acción aquí:
    // Flutter los recoge automáticamente en el siguiente build().
  }

  /// Actualiza `_textWidth` (si [remeasureText]) y la `duration` del controller
  /// **sin recrearlo**, preservando la posición actual de la animación.
  ///
  /// Técnica clave: guardamos el `value` antes de cambiar la duración y lo
  /// restauramos inmediatamente después. Así el texto no salta de posición.
  void _applyHotUpdate({required bool remeasureText}) {
    if (remeasureText) {
      _textWidth = _measureTextWidth();
    }

    // Capturamos la posición normalizada actual [0.0 – 1.0] antes de cambiar
    // la duración. Flutter ajusta internamente el valor al nuevo rango, pero
    // guardarlo explícitamente garantiza coherencia aunque el comportamiento
    // interno cambie en versiones futuras del framework.
    final double currentProgress = _scrollController.value;

    _scrollController.duration = _animationDuration;

    // Restaurar el progreso y continuar el repeat desde ese punto exacto,
    // evitando cualquier salto o flash visible.
    _scrollController
      ..value = currentProgress
      ..repeat();
  }

  /// Usa [TextPainter] para medir el ancho exacto (en píxeles lógicos) que
  /// ocupará [widget.text] con el estilo actualmente configurado.
  ///
  /// Es crítico que el [TextStyle] aquí sea idéntico al usado en el [Text]
  /// widget para que la medición coincida con el renderizado real.
  double _measureTextWidth() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: _buildTextStyle()),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.width;
  }

  /// Construye el [TextStyle] compartido entre [_measureTextWidth] y el
  /// [Text] widget para garantizar coherencia entre medición y renderizado.
  TextStyle _buildTextStyle() {
    return TextStyle(
      color: widget.ledTextColor,
      fontSize: widget.fontSize,
      fontFamily: widget.fontFamily,
      fontWeight: widget.fontWeight,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double resolvedHeight = widget.panelHeight ?? (widget.fontSize);

    return ClipRect(
      child: SizedBox(
        width: _screenWidth,
        height: resolvedHeight,
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
          // El Text vive fuera del builder como `child` para que Flutter
          // no lo reconstruya en cada frame de animación (optimización clave).
          child: SizedBox(
            width: _textWidth,
            child: OverflowBox(
              alignment: Alignment.center,
              minHeight: 0,
              maxHeight:
                  double.infinity, // permite que el texto tome su alto natural
              child: Text(
                widget.text,
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
}
