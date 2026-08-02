import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel_bloc.dart';
import 'package:led_panel/presentation/widgets/led_panel.dart';


/// Página de visualización completa del panel LED.
///
/// Al entrar:
///   - Fuerza orientación **horizontal** (landscape).
///   - Oculta la barra de estado y de navegación del sistema (immersive mode).
///
/// Al salir (back o tap):
///   - Restaura la orientación **vertical** y la UI del sistema.
///
/// El [LedPanel] ocupa el 100% del alto y ancho de [MediaQuery], centrado
/// verticalmente para que el efecto sea máximo en la pantalla apaisada.
/// 
/// Obtiene la configuración del [LedPanelBloc], eliminando prop drilling.
class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  void initState() {
    super.initState();
    _enterImmersiveLandscape();
  }

  @override
  void dispose() {
    _exitImmersivePortrait();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Control de orientación y UI del sistema
  // ---------------------------------------------------------------------------

  /// Activa el modo immersivo landscape: oculta status bar + nav bar y
  /// fuerza la rotación a horizontal.
  void _enterImmersiveLandscape() {
    // Ocultar completamente la UI del sistema (status bar + navigation bar).
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Forzar orientación landscape.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  /// Restaura la UI del sistema y la orientación portrait al salir.
  void _exitImmersivePortrait() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values, // Restaura todos los overlays.
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _handleBack() {
    _exitImmersivePortrait();
    Navigator.of(context).pop();
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // Usamos BlocBuilder para obtener la configuración del BLoC.
    return BlocBuilder<LedPanelBloc, LedPanelState>(
      builder: (context, state) {
        final config = state.config;

        // Usamos OrientationBuilder para reaccionar correctamente cuando el sistema
        // aplica el cambio de orientación y MediaQuery actualiza sus dimensiones.
        return PopScope(
          // Interceptamos el back gesture para restaurar el estado del sistema
          // antes de que Flutter ejecute el pop.
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (!didPop) _handleBack();
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            body: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                final Size screenSize = MediaQuery.of(context).size;

                // En landscape, width > height. Usamos el tamaño real reportado
                // por MediaQuery tras la rotación para dimensionar el panel.
                final double panelHeight = screenSize.height;

                return GestureDetector(
                  // Un tap en cualquier lugar regresa al configurador.
                  onTap: _handleBack,
                  child: SizedBox.expand(
                    child: ColoredBox(
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LedPanel(
                            text: config.text,
                            ledTextColor: config.ledTextColor,
                            panelBackgroundColor: config.panelBackgroundColor,
                            borderColor: config.borderColor,
                            fontSize: config.fontSize,
                            scrollSpeedPixelsPerSecond:
                                config.scrollSpeedPixelsPerSecond,
                            ledGlowRadius: config.ledGlowRadius,
                            fontWeight: config.fontWeight,
                            borderRadius: config.borderRadius,
                            // Ocupamos todo el alto disponible para máximo impacto.
                            panelHeight: panelHeight,
                            borderWidth: 0, // Sin bordes en modo display total.
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
