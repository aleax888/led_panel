import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel/led_panel_bloc.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel.dart';

/// Página de visualización completa del panel LED.
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedPanelBloc, LedPanelState>(
      builder: (context, state) {
        return PopScope(
          // Interceptamos el back gesture para restaurar el estado del sistema
          // antes de que Flutter ejecute el pop.
          canPop: false,
          onPopInvokedWithResult: (bool didPop, _) {
            if (!didPop) _handleBack();
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            body: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                return GestureDetector(
                  // Un tap en cualquier lugar regresa al configurador.
                  onTap: _handleBack,
                  child: SizedBox.expand(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [LedPanel(config: state.config)],
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

  void _enterImmersiveLandscape() {
    SystemChrome.setEnabledSystemUIMode(.immersiveSticky);
    SystemChrome.setPreferredOrientations([.landscapeLeft, .landscapeRight]);
  }

  void _exitImmersivePortrait() {
    SystemChrome.setEnabledSystemUIMode(
      .manual,
      overlays: SystemUiOverlay.values,
    );
    SystemChrome.setPreferredOrientations([.portraitUp, .portraitDown]);
  }

  void _handleBack() {
    _exitImmersivePortrait();
    Navigator.of(context).pop();
  }
}
