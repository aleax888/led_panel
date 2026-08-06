import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:led_panel/bloc/led_panel_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/presentation/pages/display_page.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_picker_field.dart';
import 'package:led_panel/presentation/widgets/font_family_selector/font_family_selector.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_durations.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Pantalla principal: configura el mensaje y la apariencia del panel LED,
/// con una vista previa en vivo y acceso a la reproducción a pantalla completa.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = context
        .read<LedPanelBloc>()
        .state
        .config
        .text;
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedPanelBloc, LedPanelState>(
      builder: (context, state) {
        final LedPanelBloc bloc = context.read<LedPanelBloc>();

        return Scaffold(
          appBar: AppBar(title: const Text('Led Panel Configuration')),
          body: SafeArea(
            child: Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                children: [
                  // Led Panel Preview ----------------------------------------------
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: AppRadius.borderRadiusLg,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                    child: LedPanel(
                      config: state.config,
                      panelHeight:
                          context.screenSize.width *
                          context.screenSize.width /
                          context.screenSize.height,
                    ),
                  ),

                  // Message ----------------------------------------------
                  TextField(
                    controller: _textEditingController,
                    onChanged: (value) {
                      bloc.add(LedPanelTextChanged(value));
                    },
                    maxLines: 2,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Escribe el mensaje del panel...',
                    ),
                  ),

                  // Configuration Controls ----------------------------------------------
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.lg,
                      ),
                      child: Column(
                        spacing: AppSpacing.md,
                        crossAxisAlignment: .stretch,
                        children: [
                          // Color ----------------------------------------------
                          ColorPickerField(
                            color: state.config.color,
                            onChanged: (color) =>
                                bloc.add(LedPanelColorChanged(color)),
                          ),

                          // Font Family ----------------------------------------------
                          FontFamilySelector(
                            selectedFontFamily: state.config.fontFamily,
                            onChanged: (fontFamily) =>
                                bloc.add(LedPanelFontFamilyChanged(fontFamily)),
                          ),

                          // Speed ----------------------------------------------
                          NumericValueSelector(
                            label: 'VELOCIDAD',
                            unit: 'px/s',
                            value: state.config.speed.round(),
                            minValue: 20,
                            maxValue: 500,
                            incrementStep: 5,
                            decrementStep: 5,
                            onChanged: (value) => bloc.add(
                              LedPanelSpeedChanged(value.toDouble()),
                            ),
                          ),

                          // Font Size ----------------------------------------------
                          NumericValueSelector(
                            label: 'TAMAÑO',
                            unit: 'pt',
                            value: state.config.fontSize.round(),
                            minValue: 14,
                            maxValue: 300,
                            incrementStep: 2,
                            decrementStep: 2,
                            onChanged: (value) => bloc.add(
                              LedPanelFontSizeChanged(value.toDouble()),
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
}
