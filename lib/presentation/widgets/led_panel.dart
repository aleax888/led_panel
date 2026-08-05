import 'package:flutter/material.dart';
import 'package:led_panel/data/led_panel_config_model.dart';
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
    milliseconds: (_totalAnimationTravel / widget.config.speed * 1000).round(),
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
        oldWidget.config.text != widget.config.text ||
        oldWidget.config.fontSize != widget.config.fontSize;

    final bool affectsSpeedOnly =
        !affectsTextWidth && oldWidget.config.speed != widget.config.speed;

    if (affectsTextWidth || affectsSpeedOnly) {
      _applyHotUpdate(remeasureText: affectsTextWidth);
    }
    // Cambios de color, glow, borderRadius, etc. no requieren acción aquí:
    // Flutter los recoge automáticamente en el siguiente build().
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double resolvedHeight =
        widget.panelHeight ?? (widget.config.fontSize);

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
      text: TextSpan(text: widget.config.text, style: _buildTextStyle()),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.width;
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
