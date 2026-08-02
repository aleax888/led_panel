import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
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

  /// Intensidad del resplandor LED (blur radius del shadow).
  final double ledGlowRadius;

  /// Tamaño de la fuente del texto LED.
  final double fontSize;

  /// Familia tipográfica. Se recomienda una monoespaciada para mayor realismo.
  final String fontFamily;

  /// Peso de la fuente.
  final FontWeight fontWeight;

  /// Alto del panel LED. Si es null, se ajusta al contenido más padding.
  final double? panelHeight;

  /// Padding vertical interno del panel.
  final double verticalPadding;

  /// Radio de los bordes del panel.
  final double borderRadius;

  /// Color del borde exterior del panel (marco metálico).
  final Color borderColor;

  /// Grosor del borde exterior del panel.
  final double borderWidth;

  const LedPanel({
    super.key,
    required this.text,
    this.scrollSpeedPixelsPerSecond = 80.0,
    this.panelBackgroundColor = _LedPanelDefaults.panelBackgroundColor,
    this.ledTextColor = _LedPanelDefaults.ledTextColor,
    this.ledGlowColor,
    this.ledGlowRadius = _LedPanelDefaults.glowRadius,
    this.fontSize = _LedPanelDefaults.fontSize,
    this.fontFamily = AppTypography.fontFamilyMono,
    this.fontWeight = AppTypography.bold,
    this.panelHeight,
    this.verticalPadding = _LedPanelDefaults.verticalPadding,
    this.borderRadius = AppRadius.sm,
    this.borderColor = _LedPanelDefaults.borderColor,
    this.borderWidth = _LedPanelDefaults.borderWidth,
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
    final Color resolvedGlowColor = widget.ledGlowColor ??
        widget.ledTextColor.withValues(
          alpha: _LedPanelDefaults.primaryGlowOpacity,
        );

    return TextStyle(
      color: widget.ledTextColor,
      fontSize: widget.fontSize,
      fontFamily: widget.fontFamily,
      fontWeight: widget.fontWeight,
      // El doble shadow simula el resplandor característico de los LEDs reales.
      shadows: [
        Shadow(color: resolvedGlowColor, blurRadius: widget.ledGlowRadius),
        Shadow(
          color: resolvedGlowColor.withValues(
            alpha: _LedPanelDefaults.secondaryGlowOpacity,
          ),
          blurRadius: widget.ledGlowRadius * _LedPanelDefaults.secondaryGlowMultiplier,
        ),
      ],
    );
  }

  /// Decoración del "chasis" del panel: color de fondo, marco y la sombra
  /// que le da sensación de profundidad sobre la superficie.
  BoxDecoration _buildPanelDecoration() {
    return BoxDecoration(
      color: widget.panelBackgroundColor,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      border: Border.all(color: widget.borderColor, width: widget.borderWidth),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(
            alpha: _LedPanelDefaults.outerShadowOpacity,
          ),
          blurRadius: _LedPanelDefaults.outerShadowBlurRadius,
          offset: _LedPanelDefaults.outerShadowOffset,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double resolvedHeight =
        widget.panelHeight ?? (widget.fontSize + widget.verticalPadding * 2);

    return Container(
      width: _screenWidth,
      height: resolvedHeight,
      decoration: _buildPanelDecoration(),
      // ClipRect es el guardián del overflow: impide que el texto sea visible
      // fuera de los límites del panel durante su recorrido de animación.
      child: ClipRect(
        child: SizedBox(
          width: _screenWidth,
          height: resolvedHeight,
          child: AnimatedBuilder(
            animation: _scrollController,
            builder: (BuildContext context, Widget? child) {
              return Stack(
                children: [
                  // Rejilla decorativa de puntos LED apagados (fondo del panel).
                  _LedDotGrid(width: _screenWidth, height: resolvedHeight),
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
            child: Align(
              alignment: Alignment.centerLeft,
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

// =============================================================================
// Constantes y widgets internos de soporte
// =============================================================================

/// Valores por defecto y constantes internas de [LedPanel].
///
/// Representan la estética de un panel LED físico (chasis, resplandor,
/// rejilla de puntos apagados). Se mantienen deliberadamente separados de
/// la paleta de marca de la app (`AppColors`): este widget simula un
/// dispositivo real, no una superficie de la interfaz.
class _LedPanelDefaults {
  _LedPanelDefaults._();

  // Apariencia por defecto del chasis y el texto LED.
  static const Color panelBackgroundColor = Color(0xFF0A0A0A);
  static const Color ledTextColor = Color(0xFFFF4500);
  static const Color borderColor = Color(0xFF333333);
  static const double borderWidth = 2.5;
  static const double glowRadius = 12.0;
  static const double fontSize = 28.0;
  static const double verticalPadding = 10.0;

  // Resplandor del texto LED (doble sombra: núcleo + difusión).
  static const double primaryGlowOpacity = 0.9;
  static const double secondaryGlowOpacity = 0.5;
  static const double secondaryGlowMultiplier = 2.5;

  // Sombra exterior del panel (profundidad sobre la superficie).
  static const double outerShadowOpacity = 0.6;
  static const double outerShadowBlurRadius = 8.0;
  static const Offset outerShadowOffset = Offset(0, 4);

  // Rejilla decorativa de puntos LED apagados.
  static const double dotGridOpacity = 0.03;
  static const double dotGridSpacing = 6.0;
  static const double dotGridRadius = 1.0;
}

/// Dibuja una rejilla de puntos diminutos para simular la matriz de LEDs
/// apagados que caracteriza a los paneles físicos reales.
class _LedDotGrid extends StatelessWidget {
  final double width;
  final double height;

  const _LedDotGrid({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _LedDotPainter(),
    );
  }
}

/// [CustomPainter] que dibuja la rejilla de puntos LED apagados.
///
/// No expone configuración: el color y el espaciado son fijos
/// ([_LedPanelDefaults]), por lo que nunca necesita repintarse.
class _LedDotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.white.withValues(alpha: _LedPanelDefaults.dotGridOpacity)
      ..style = PaintingStyle.fill;

    for (double x = _LedPanelDefaults.dotGridSpacing / 2;
        x < size.width;
        x += _LedPanelDefaults.dotGridSpacing) {
      for (double y = _LedPanelDefaults.dotGridSpacing / 2;
          y < size.height;
          y += _LedPanelDefaults.dotGridSpacing) {
        canvas.drawCircle(Offset(x, y), _LedPanelDefaults.dotGridRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LedDotPainter oldDelegate) => false;
}