import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel_bloc.dart';
import 'package:led_panel/data/led_panel_config_model.dart';
import 'package:led_panel/presentation/widgets/app_switch.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_picker_field.dart';
import 'package:led_panel/presentation/widgets/input_label.dart';
import 'package:led_panel/presentation/widgets/led_panel.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';
import 'package:led_panel/theme/constants/app_durations.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

import 'display_page.dart';

/// Pantalla principal: configura el mensaje y la apariencia del panel LED,
/// con una vista previa en vivo y acceso a la reproducción a pantalla completa.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _textEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    // Solo orientación vertical en la HomePage.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _navigateToDisplay() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, _) => const DisplayPage(),
        transitionsBuilder: (_, animation, _, child) => FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
          child: child,
        ),
        transitionDuration: AppDurations.slow,
      ),
    );
  }

  /// Sincroniza el controlador de texto con el estado del bloc sin
  /// pisar la posición del cursor mientras el usuario está escribiendo.
  void _syncTextController(String text) {
    final String trimmed = text.trim();
    if (_textEditingController.text != trimmed) {
      _textEditingController.text = trimmed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedPanelBloc, LedPanelState>(
      builder: (context, state) {
        final LedPanelConfig config = state.config;
        _syncTextController(config.text);

        final Size screenSize = MediaQuery.sizeOf(context);
        final LedPanelBloc bloc = context.read<LedPanelBloc>();

        return Scaffold(
          appBar: AppBar(title: const Text('Led Panel Configurator')),
          body: SafeArea(
            child: Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                children: [
                  // Led Panel Preview ----------------------------------------------
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                    child: LedPanel(
                      text: config.text,
                      ledTextColor: config.ledTextColor,
                      panelBackgroundColor: config.panelBackgroundColor,
                      borderColor: config.borderColor,
                      fontSize: config.fontSize,
                      scrollSpeedPixelsPerSecond: config.scrollSpeedPixelsPerSecond,
                      ledGlowRadius: config.ledGlowRadius,
                      fontWeight: config.fontWeight,
                      borderRadius: config.borderRadius,
                      panelHeight:
                          screenSize.width * screenSize.width / screenSize.height,
                    ),
                  ),
              
                  // Configuration Controls ----------------------------------------------
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                      child: Column(
                        spacing: AppSpacing.md,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Message ----------------------------------------------
                          TextField(
                            controller: _textEditingController,
                            onChanged: (value) =>
                                bloc.add(LedPanelTextChanged('  $value  ')),
                            maxLines: 2,
                            minLines: 1,
              
                            decoration: const InputDecoration(
                              hintText: 'Escribe el mensaje del panel...',
                            ),
                          ),
              
                          // Color ----------------------------------------------
                          ColorPickerField(
                            config: config,
                            onColorChanged: (color) {
                              bloc.add(LedPanelColorChanged(color));
                              Navigator.of(context).pop();
                            },
                          ),
              
                          // Font Weight ----------------------------------------------
                          AppSwitch(
                            isOn: config.fontWeight == FontWeight.bold,
                            onChanged: (isBold) => bloc.add(
                              LedPanelFontWeightChanged(
                                isBold ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
              
                          // Speed ----------------------------------------------
                          InputLabel(
                            label:
                                'VELOCIDAD  ${config.scrollSpeedPixelsPerSecond.round()} px/s',
                            child: NumericValueSelector(
                              initialValue: config.scrollSpeedPixelsPerSecond
                                  .round(),
                              minValue: 20,
                              maxValue: 200,
                              incrementStep: 5,
                              decrementStep: 5,
                              onChanged: (value) => bloc.add(
                                LedPanelSpeedChanged(value.toDouble()),
                              ),
                            ),
                          ),
              
                          // Font Size ----------------------------------------------
                          InputLabel(
                            label: 'TAMAÑO  ${config.fontSize.round()} pt',
                            child: NumericValueSelector(
                              initialValue: config.fontSize.round(),
                              minValue: 14,
                              maxValue: 300,
                              incrementStep: 2,
                              decrementStep: 2,
                              onChanged: (value) => bloc.add(
                                LedPanelFontSizeChanged(value.toDouble()),
                              ),
                            ),
                          ),
              
                          // Glow Radius ----------------------------------------------
                          InputLabel(
                            label:
                                'RESPLANDOR  ${config.ledGlowRadius.round()} px',
                            child: NumericValueSelector(
                              initialValue: config.ledGlowRadius.round(),
                              minValue: 0,
                              maxValue: 30,
                              incrementStep: 1,
                              decrementStep: 1,
                              onChanged: (value) => bloc.add(
                                LedPanelGlowRadiusChanged(value.toDouble()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Play Button ------------------------------------------------------
          floatingActionButton: FloatingActionButton(
            onPressed: _navigateToDisplay,
            child: const Icon(Icons.play_arrow),
          ),
        );
      },
    );
  }
}
