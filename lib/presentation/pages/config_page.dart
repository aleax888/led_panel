import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:led_panel/bloc/led_panel/led_panel_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel_list/led_panel_list_bloc.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';

import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/presentation/pages/display_page.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_picker_field.dart';
import 'package:led_panel/presentation/widgets/direction_selector/direction_selector.dart';
import 'package:led_panel/presentation/widgets/font_family_selector/font_family_selector.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/multi_tabs_view.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/separated_list_tab.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Configuration page.
class ConfigPage extends StatefulWidget {
  final LedPanelConfigModel? initialConfig;
  const ConfigPage({super.key, this.initialConfig});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final LedPanelBloc ledPanelBloc = context.read<LedPanelBloc>();
    ledPanelBloc.add(LedPanelConfigSelected(widget.initialConfig));
    _messageController.text = ledPanelBloc.state.config.text.message;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void deactivate() {
    _saveConfig(updateSelectedConfig: false);
    context.read<LedPanelBloc>().add(LedPanelUnselected());
    super.deactivate();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedPanelBloc, LedPanelState>(
      builder: (context, state) {
        final LedPanelBloc ledPanelBloc = context.read<LedPanelBloc>();
        final double fixedPanelWidth =
            context.screenSize.width - AppSpacing.screenPadding.horizontal;
        final double fixedPanelHeight =
            ((context.screenSize.width - AppSpacing.screenPadding.horizontal) *
                context.screenSize.width) /
            context.screenSize.height;
        final double proportion = fixedPanelWidth / context.screenSize.height;

        return Scaffold(
          appBar: AppBar(title: const Text('Customization')),
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
                        panelWidth: fixedPanelWidth,
                        panelHeight: fixedPanelHeight,
                        borderRadius: AppRadius.borderRadiusLg,
                        config: state.config.copyWithProportion(proportion),
                      ),
                      // Play Button ----------------------------------------------
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

                // Configuration Controls ----------------------------------------------
                Expanded(
                  child: Padding(
                    padding: AppSpacing.screenPadding,
                    child: MultiTabsView(
                      tabNames: ['Text', 'Effect', 'BG'],
                      tabViews: [
                        SeparatedListTab(
                          children: [
                            // Message ----------------------------------------------
                            TextField(
                              controller: _messageController,
                              focusNode: _messageFocusNode,
                              onChanged: (value) {
                                ledPanelBloc.add(LedPanelTextChanged(value));
                              },
                              onSubmitted: (value) {
                                _messageFocusNode.unfocus();
                              },
                              onEditingComplete: () {
                                _messageFocusNode.unfocus();
                              },
                              onTapOutside: (event) {
                                _messageFocusNode.unfocus();
                              },
                              maxLines: 2,
                              minLines: 1,
                              decoration: InputDecoration(
                                hintText: 'Type your message...',
                              ),
                            ),

                            // Color ----------------------------------------------
                            ColorPickerField(
                              color: state.config.text.color,
                              onChanged: (color) => ledPanelBloc.add(
                                LedPanelTextColorChanged(color),
                              ),
                            ),

                            // Font Family ----------------------------------------------
                            FontFamilySelector(
                              selectedFontFamily: state.config.text.fontFamily,
                              onChanged: (fontFamily) => ledPanelBloc.add(
                                LedPanelFontFamilyChanged(fontFamily),
                              ),
                            ),

                            // Font Size ----------------------------------------------
                            NumericValueSelector(
                              label: 'SIZE',
                              unit: 'pt',
                              value: state.config.text.fontSize.round(),
                              minValue: 100,
                              maxValue: 300,
                              incrementStep: 2,
                              decrementStep: 2,
                              onChanged: (value) => ledPanelBloc.add(
                                LedPanelFontSizeChanged(value.toDouble()),
                              ),
                            ),

                            // Glow Radius ----------------------------------------------
                            NumericValueSelector(
                              label: 'GLOW',
                              unit: 'pt',
                              value: state.config.text.glowRadius.round(),
                              minValue: 0,
                              maxValue: 50,
                              incrementStep: 1,
                              decrementStep: 1,
                              onChanged: (value) => ledPanelBloc.add(
                                LedPanelGlowRadiusChanged(value.toDouble()),
                              ),
                            ),

                            // Letter Spacing ----------------------------------------------
                            NumericValueSelector(
                              label: 'LETTER SPACING',
                              unit: 'pt',
                              value: state.config.text.letterSpacing.round(),
                              minValue: -10,
                              maxValue: 50,
                              incrementStep: 1,
                              decrementStep: 1,
                              onChanged: (value) => ledPanelBloc.add(
                                LedPanelLetterSpacingChanged(value.toDouble()),
                              ),
                            ),

                            // Word Spacing ----------------------------------------------
                            NumericValueSelector(
                              label: 'WORD SPACING',
                              unit: 'pt',
                              value: state.config.text.wordSpacing.round(),
                              minValue: -10,
                              maxValue: 50,
                              incrementStep: 1,
                              decrementStep: 1,
                              onChanged: (value) => ledPanelBloc.add(
                                LedPanelWordSpacingChanged(value.toDouble()),
                              ),
                            ),
                          ],
                        ),
                        SeparatedListTab(
                          children: [
                            // Direction ----------------------------------------------
                            // DirectionSelector(
                            //   selectedDirection: state.config.direction,
                            //   onChanged: (direction) => ledPanelBloc.add(
                            //     LedPanelDirectionChanged(direction),
                            //   ),
                            // ),

                            // // Speed ----------------------------------------------
                            // NumericValueSelector(
                            //   label: 'SPEED',
                            //   unit: 'px/s',
                            //   value: state.config.speed.round(),
                            //   minValue: 20,
                            //   maxValue: 500,
                            //   incrementStep: 5,
                            //   decrementStep: 5,
                            //   onChanged: (value) => ledPanelBloc.add(
                            //     LedPanelSpeedChanged(value.toDouble()),
                            //   ),
                            // ),
                          ],
                        ),
                        SeparatedListTab(
                          children: [
                            // Background Color ----------------------------------------------
                            ColorPickerField(
                              label: 'BG',
                              color: state.config.background.color,
                              onChanged: (color) => ledPanelBloc.add(
                                LedPanelBackgroundColorChanged(color),
                              ),
                            ),

                            // Leds Color ----------------------------------------------
                            ColorPickerField(
                              label: 'LEDs',
                              color: state.config.background.ledsColor,
                              onChanged: (color) => ledPanelBloc.add(
                                LedPanelLedsColorChanged(color),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToDisplay() {
    _saveConfig();
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const DisplayPage()));
  }

  void _saveConfig({bool updateSelectedConfig = true}) {
    final LedPanelBloc ledPanelBloc = context.read<LedPanelBloc>();
    final LedPanelListBloc ledPanelListBloc = context.read<LedPanelListBloc>();
    ledPanelListBloc.add(
      LedPanelListConfigSaved(
        ledPanelBloc.state.config,
        (config) => updateSelectedConfig
            ? ledPanelBloc.add(LedPanelConfigSelected(config))
            : null,
      ),
    );
  }
}
