import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/domain/led_panel_config_model.dart';
import 'package:led_panel/bloc/led_panel_bloc.dart';
import 'package:led_panel/widgets/color_picker.dart';
import 'package:led_panel/widgets/input_label.dart';

import '../widgets/led_panel.dart';
import '../widgets/quantity_counter.dart';
import 'display_page.dart';

// =============================================================================
// HomePage
// =============================================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Controlador del campo de texto del mensaje.
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
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

  // ---------------------------------------------------------------------------
  // Handlers
  // ---------------------------------------------------------------------------

  void _navigateToDisplay() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => const DisplayPage(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedPanelBloc, LedPanelState>(
      builder: (context, state) {
        final config = state.config;
        _textEditingController.text = config.text.trim();

        return Scaffold(
          backgroundColor: const Color(0xFF111111),
          body: SafeArea(
            child: Column(
              children: [
                // Preview en vivo del panel con la configuración actual.
                LedPanel(
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
                      MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height /
                          MediaQuery.of(context).size.width),
                ),
                // Panel de controles scrolleable.
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Message
                        Column(
                          children: [
                            const InputLabel(label: 'MENSAJE'),
                            BlocBuilder<LedPanelBloc, LedPanelState>(
                              builder: (context, state) {
                                final config = state.config;
                                return Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1C1C1C),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: const Color(0xFF2A2A2A),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _textEditingController,
                                    onChanged: (value) => context
                                        .read<LedPanelBloc>()
                                        .add(LedPanelTextChanged('  $value  ')),
                                    style: TextStyle(
                                      color: config.ledTextColor,
                                      fontFamily: 'Courier',
                                      fontSize: 16,
                                      shadows: [
                                        Shadow(
                                          color: config.ledTextColor
                                              .withOpacity(0.6),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    cursorColor: config.ledTextColor,
                                    decoration: const InputDecoration(
                                      hintText:
                                          'Escribe el mensaje del panel...',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF3A3A3A),
                                        fontFamily: 'Courier',
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 12,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 2,
                                    minLines: 1,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_) =>
                                        FocusScope.of(context).unfocus(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        // Color + Font Weight
                        Row(
                          children: [
                            Expanded(
                              child: ColorPickerField(
                                config: config,
                                onColorChanged: (color) {
                                  context.read<LedPanelBloc>().add(
                                    LedPanelColorChanged(color),
                                  );
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Expanded(child: _buildFontWeightToggle(config)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Column(
                              children: [
                                // Scroll Speed
                                InputLabel(
                                  label:
                                      'VELOCIDAD  ${config.scrollSpeedPixelsPerSecond.round()} px/s',
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: QuantityCounter(
                                    initialValue: config
                                        .scrollSpeedPixelsPerSecond
                                        .round(),
                                    minValue: 20,
                                    maxValue: 200,
                                    incrementStep: 5,
                                    decrementStep: 5,
                                    buttonColor: config.ledTextColor,
                                    onChanged: (value) =>
                                        context.read<LedPanelBloc>().add(
                                          LedPanelSpeedChanged(
                                            value.toDouble(),
                                          ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                // Font Size
                                InputLabel(
                                  label:
                                      'TAMAÑO  ${config.fontSize.round()} pt',
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: QuantityCounter(
                                    initialValue: config.fontSize.round(),
                                    minValue: 14,
                                    maxValue: 300,
                                    incrementStep: 2,
                                    decrementStep: 2,
                                    buttonColor: config.ledTextColor,
                                    onChanged: (value) =>
                                        context.read<LedPanelBloc>().add(
                                          LedPanelFontSizeChanged(
                                            value.toDouble(),
                                          ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Column(
                              children: [
                                // Resplandor
                                InputLabel(
                                  label:
                                      'RESPLANDOR  ${config.ledGlowRadius.round()} px',
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: QuantityCounter(
                                    initialValue: config.ledGlowRadius.round(),
                                    minValue: 0,
                                    maxValue: 30,
                                    incrementStep: 1,
                                    decrementStep: 1,
                                    buttonColor: config.ledTextColor,
                                    onChanged: (value) =>
                                        context.read<LedPanelBloc>().add(
                                          LedPanelGlowRadiusChanged(
                                            value.toDouble(),
                                          ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                // Bordes
                                InputLabel(
                                  label:
                                      'BORDES  ${config.borderRadius.round()} px',
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: QuantityCounter(
                                    initialValue: config.borderRadius.round(),
                                    minValue: 0,
                                    maxValue: 20,
                                    incrementStep: 1,
                                    decrementStep: 1,
                                    buttonColor: config.ledTextColor,
                                    onChanged: (value) =>
                                        context.read<LedPanelBloc>().add(
                                          LedPanelBorderRadiusChanged(
                                            value.toDouble(),
                                          ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _navigateToDisplay,
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      color: config.ledTextColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: config.ledTextColor.withOpacity(0.45),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'GO!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Courier',
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFontWeightToggle(LedPanelConfig config) {
    final bool isBold = config.fontWeight == FontWeight.bold;

    return Row(
      children: [
        const InputLabel(label: 'NEGRITA'),
        const Spacer(),
        GestureDetector(
          onTap: () => context.read<LedPanelBloc>().add(
            LedPanelFontWeightChanged(
              isBold ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 48,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: isBold ? config.ledTextColor : const Color(0xFF2A2A2A),
              boxShadow: isBold
                  ? [
                      BoxShadow(
                        color: config.ledTextColor.withOpacity(0.4),
                        blurRadius: 8,
                      ),
                    ]
                  : [],
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: isBold ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isBold ? Colors.white : const Color(0xFF555555),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
