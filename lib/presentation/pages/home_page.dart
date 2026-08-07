import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:led_panel/bloc/led_panel_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/presentation/pages/display_page.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_picker_field.dart';
import 'package:led_panel/presentation/widgets/direction_selector/direction_selector.dart';
import 'package:led_panel/presentation/widgets/font_family_selector/font_family_selector.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/multi_tabs_view.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/scrollable_tab.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';
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
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messageController.text = context.read<LedPanelBloc>().state.config.text;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedPanelBloc, LedPanelState>(
      builder: (context, state) {
        final LedPanelBloc bloc = context.read<LedPanelBloc>();
        final double fixedPanelWidth =
            context.screenSize.width - AppSpacing.screenPadding.horizontal;
        final double fixedPanelHeight =
            ((context.screenSize.width - AppSpacing.screenPadding.horizontal) *
                context.screenSize.width) /
            context.screenSize.height;
        final double proportion = fixedPanelWidth / context.screenSize.height;

        return Scaffold(
          appBar: AppBar(title: const Text('Led Panel Configuration')),
          body: SafeArea(
            child: Column(
              spacing: AppSpacing.md,
              children: [
                SizedBox(),
                // Led Panel Preview ----------------------------------------------
                Container(
                  margin: AppSpacing.screenPadding,
                  child: Stack(
                    children: [
                      LedPanel(
                        config: state.config.copyWithProportion(proportion),
                        panelWidth: fixedPanelWidth,
                        panelHeight: fixedPanelHeight,
                        borderRadius: AppRadius.borderRadiusLg,
                      ),
                      // Play Button ------------------------------------------------------
                      Positioned(
                        right: AppSpacing.xs,
                        top: AppSpacing.xs,
                        child: IconButton(
                          onPressed: _navigateToDisplay,
                          icon: Icon(
                            Icons.open_in_full_rounded,
                            color: context.colors.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Message ----------------------------------------------
                Padding(
                  padding: AppSpacing.screenPadding,
                  child: TextField(
                    controller: _messageController,
                    onChanged: (value) {
                      bloc.add(LedPanelTextChanged(value));
                    },
                    maxLines: 2,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Escribe el mensaje del panel...',
                    ),
                  ),
                ),

                // Configuration Controls ----------------------------------------------
                Expanded(
                  child: MultiTabsView(
                    tabNames: ['Texto', 'Animación y Fondo'],
                    tabViews: [
                      ScrollableTab(
                        children: [
                          // Color ----------------------------------------------
                          ColorPickerField(
                            color: state.config.textColor,
                            onChanged: (color) =>
                                bloc.add(LedPanelTextColorChanged(color)),
                          ),

                          // Font Family ----------------------------------------------
                          FontFamilySelector(
                            selectedFontFamily: state.config.fontFamily,
                            onChanged: (fontFamily) =>
                                bloc.add(LedPanelFontFamilyChanged(fontFamily)),
                          ),

                          // Font Size ----------------------------------------------
                          NumericValueSelector(
                            label: 'TAMAÑO',
                            unit: 'pt',
                            value: state.config.fontSize.round(),
                            minValue: 100,
                            maxValue: 300,
                            incrementStep: 2,
                            decrementStep: 2,
                            onChanged: (value) => bloc.add(
                              LedPanelFontSizeChanged(value.toDouble()),
                            ),
                          ),

                          // Letter Spacing ----------------------------------------------
                          NumericValueSelector(
                            label: 'ESPACIADO ENTRE LETRAS',
                            unit: 'pt',
                            value: state.config.letterSpacing.round(),
                            minValue: -10,
                            maxValue: 50,
                            incrementStep: 1,
                            decrementStep: 1,
                            onChanged: (value) => bloc.add(
                              LedPanelLetterSpacingChanged(value.toDouble()),
                            ),
                          ),

                          // Word Spacing ----------------------------------------------
                          NumericValueSelector(
                            label: 'ESPACIADO ENTRE PALABRAS',
                            unit: 'pt',
                            value: state.config.wordSpacing.round(),
                            minValue: -10,
                            maxValue: 50,
                            incrementStep: 1,
                            decrementStep: 1,
                            onChanged: (value) => bloc.add(
                              LedPanelWordSpacingChanged(value.toDouble()),
                            ),
                          ),
                          // Glow Radius ----------------------------------------------
                          NumericValueSelector(
                            label: 'RESPLANDOR',
                            unit: 'pt',
                            value: state.config.glowRadius.round(),
                            minValue: 0,
                            maxValue: 50,
                            incrementStep: 1,
                            decrementStep: 1,
                            onChanged: (value) => bloc.add(
                              LedPanelGlowRadiusChanged(value.toDouble()),
                            ),
                          ),
                          SizedBox(),
                        ],
                      ),
                      ScrollableTab(
                        children: [
                          // Direction ----------------------------------------------
                          DirectionSelector(
                            selectedDirection: state.config.direction,
                            onChanged: (direction) => bloc.add(
                              LedPanelDirectionChanged(direction),
                            ),
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

                          // Background Color ----------------------------------------------
                          ColorPickerField(
                            label: 'FONDO',
                            color: state.config.backgroundColor,
                            onChanged: (color) =>
                                bloc.add(LedPanelBackgroundColorChanged(color)),
                          ),

                          // Leds Color ----------------------------------------------
                          ColorPickerField(
                            label: 'LEDS',
                            color: state.config.ledsColor,
                            onChanged: (color) =>
                                bloc.add(LedPanelLedsColorChanged(color)),
                          ),
                          SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
