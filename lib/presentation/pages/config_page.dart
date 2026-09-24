import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:led_panel/bloc/animations/crawl/crawl_cubit.dart';
import 'package:led_panel/bloc/animations/marquee/marquee_cubit.dart';
import 'package:led_panel/bloc/animations/scramble/scramble_cubit.dart';
import 'package:led_panel/bloc/animations/typewritter/typewritter_cubit.dart';
import 'package:led_panel/bloc/animations/wave/wave_cubit.dart';

import 'package:led_panel/bloc/led_panel/led_panel_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel_list/led_panel_list_bloc.dart';
import 'package:led_panel/data/enums/animation_type_enum.dart';
import 'package:led_panel/data/enums/crawl_direction_enum.dart';
import 'package:led_panel/data/enums/marquee_direction_enum.dart';
import 'package:led_panel/data/models/animations/crawl_config_model.dart';
import 'package:led_panel/data/models/animations/marquee_config_model.dart';
import 'package:led_panel/data/models/animations/scramble_config_model.dart';
import 'package:led_panel/data/models/animations/typewriter_config_model.dart';
import 'package:led_panel/data/models/animations/wave_config_model.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';

import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/presentation/pages/display_page.dart';
import 'package:led_panel/presentation/widgets/animation_selector/animation_selector.dart';
import 'package:led_panel/presentation/widgets/color_picker/color_picker_field.dart';
import 'package:led_panel/presentation/widgets/direction_selector/direction_selector.dart';
import 'package:led_panel/presentation/widgets/font_family_selector/font_family_selector.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/multi_tabs_view.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/separated_list_tab.dart';
import 'package:led_panel/presentation/widgets/numeric_value_selector/numeric_value_selector.dart';
import 'package:led_panel/presentation/widgets/shape_selector/shape_selector.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/utils/toast_handler.dart';

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
          appBar: AppBar(
            title: Text('CUSTOMIZATION', style: context.textTheme.labelLarge),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () => ToastHandler.showInfo(
                  'Sharing functionality is not implemented yet.',
                ),
              ),
            ],
          ),
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
                      tabNames: ['Text', 'Anim', 'BG'],
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
                            // Animation Type ----------------------------------------------
                            AnimationSelector(
                              selectedAnimation: state.config.animation.type,
                              onChanged: (animationType) => ledPanelBloc.add(
                                LedPanelAnimationTypeChanged(animationType),
                              ),
                            ),

                            // Animation Config ----------------------------------------------
                            ..._buildAnimationConfig(
                              state.config.animation.type,
                              ledPanelBloc,
                            ),
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

                            // Leds Shape ----------------------------------------------
                            ShapeSelector(
                              selectedShape: state.config.background.ledsShape,
                              onChanged: (shape) => ledPanelBloc.add(
                                LedPanelLedsShapeChanged(shape),
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

  List<Widget> _buildAnimationConfig(
    final AnimationTypeEnum animationType,
    final LedPanelBloc ledPanelBloc,
  ) {
    switch (animationType) {
      case .none:
        return [];
      case .marquee:
        final marqueeCubit = context.read<MarqueeCubit>();
        return [
          // Direction ----------------------------------------------
          DirectionSelector(
            options: MarqueeDirectionEnum.values,
            selectedDirection:
                (ledPanelBloc.state.config.animation as MarqueeConfigModel)
                    .direction,
            onChanged: (direction) {
              marqueeCubit.onDirectionChanged(direction);
              ledPanelBloc.add(
                LedPanelAnimationConfigChanged(marqueeCubit.state.config),
              );
            },
          ),

          // Speed ----------------------------------------------
          NumericValueSelector(
            label: 'SPEED',
            unit: 'px/s',
            value: (ledPanelBloc.state.config.animation as MarqueeConfigModel)
                .speed
                .round(),
            minValue: 20,
            maxValue: 500,
            incrementStep: 5,
            decrementStep: 5,
            onChanged: (speed) {
              marqueeCubit.onSpeedChanged(speed.toDouble());
              ledPanelBloc.add(
                LedPanelAnimationConfigChanged(marqueeCubit.state.config),
              );
            },
          ),
        ];
      case .typewriter:
        final typewritterCubit = context.read<TypewritterCubit>();
        return [
          // Character Duration ----------------------------------------------
          NumericValueSelector(
            label: 'CHARACTER DURATION',
            unit: 'ms',
            value:
                (ledPanelBloc.state.config.animation as TypewriterConfigModel)
                    .characterDuration
                    .inMilliseconds
                    .round(),
            minValue: 20,
            maxValue: 500,
            incrementStep: 5,
            decrementStep: 5,
            onChanged: (duration) {
              typewritterCubit.onCharacterDurationChanged(duration);
              ledPanelBloc.add(
                LedPanelAnimationConfigChanged(typewritterCubit.state.config),
              );
            },
          ),

          // Character Duration Noise ----------------------------------------------
          NumericValueSelector(
            label: 'CHARACTER DURATION NOISE',
            unit: 'ms',
            value:
                (ledPanelBloc.state.config.animation as TypewriterConfigModel)
                    .characterDurationNoise
                    .inMilliseconds
                    .round(),
            minValue: 0,
            maxValue: 1000,
            incrementStep: 10,
            decrementStep: 10,
            onChanged: (duration) {
              typewritterCubit.onCharacterDurationNoiseChanged(duration);
              ledPanelBloc.add(
                LedPanelAnimationConfigChanged(typewritterCubit.state.config),
              );
            },
          ),

          // Completion Pause ----------------------------------------------
          NumericValueSelector(
            label: 'COMPLETION PAUSE',
            unit: 'ms',
            value:
                (ledPanelBloc.state.config.animation as TypewriterConfigModel)
                    .completionPause
                    .inMilliseconds
                    .round(),
            minValue: 0,
            maxValue: 5000,
            incrementStep: 50,
            decrementStep: 50,
            onChanged: (duration) {
              typewritterCubit.onCompletionPauseChanged(duration);
              ledPanelBloc.add(
                LedPanelAnimationConfigChanged(typewritterCubit.state.config),
              );
            },
          ),
        ];
      case .wave:
        final waveCubit = context.read<WaveCubit>();
        return [
          // Amplitude ----------------------------------------------
          NumericValueSelector(
            label: 'AMPLITUDE',
            unit: 'XD',
            value: (ledPanelBloc.state.config.animation as WaveConfigModel)
                .amplitude
                .round(),
            minValue: 0,
            maxValue: 50,
            incrementStep: 5,
            decrementStep: 5,
            onChanged: (amplitude) {
              waveCubit.onAmplitudeChanged(amplitude.toDouble());
              ledPanelBloc.add(
                LedPanelAnimationConfigChanged(waveCubit.state.config),
              );
            },
          ),

          // Frequency ----------------------------------------------
          NumericValueSelector(
            label: 'FREQUENCY',
            unit: 'XD',
            value: (ledPanelBloc.state.config.animation as WaveConfigModel)
                .frequency
                .round(),
            minValue: 0,
            maxValue: 20,
            incrementStep: 5,
            decrementStep: 5,
            onChanged: (frequency) {
              waveCubit.onFrequencyChanged(frequency.toDouble());
              ledPanelBloc.add(
                LedPanelAnimationConfigChanged(waveCubit.state.config),
              );
            },
          ),

          // Phase Step ----------------------------------------------
          NumericValueSelector(
            label: 'PHASE STEP',
            unit: 'XD',
            value: (ledPanelBloc.state.config.animation as WaveConfigModel)
                .phaseStep
                .round(),
            minValue: 0,
            maxValue: 20,
            incrementStep: 5,
            decrementStep: 5,
            onChanged: (phaseStep) {
              waveCubit.onPhaseStepChanged(phaseStep.toDouble());
              ledPanelBloc.add(
                LedPanelAnimationConfigChanged(waveCubit.state.config),
              );
            },
          ),
        ];
      case .scramble:
        final scrambleCubit = context.read<ScrambleCubit>();
        return [
          // Character Duration ----------------------------------------------
          NumericValueSelector(
            label: 'CHARACTER DURATION',
            unit: 'ms',
            value: (ledPanelBloc.state.config.animation as ScrambleConfigModel)
                .characterDuration
                .inMilliseconds
                .round(),
            minValue: 20,
            maxValue: 500,
            incrementStep: 5,
            decrementStep: 5,
            onChanged: (duration) {
              scrambleCubit.onCharacterDurationChanged(duration);
              ledPanelBloc.add(
                LedPanelAnimationConfigChanged(scrambleCubit.state.config),
              );
            },
          ),

          // Completion Pause ----------------------------------------------
          NumericValueSelector(
            label: 'COMPLETION PAUSE',
            unit: 'ms',
            value: (ledPanelBloc.state.config.animation as ScrambleConfigModel)
                .completionPause
                .inMilliseconds
                .round(),
            minValue: 0,
            maxValue: 5000,
            incrementStep: 50,
            decrementStep: 50,
            onChanged: (duration) {
              scrambleCubit.onCompletionPauseChanged(duration);
              ledPanelBloc.add(
                LedPanelAnimationConfigChanged(scrambleCubit.state.config),
              );
            },
          ),

          // Scramble Characters ----------------------------------------------
          // TODO
        ];
      case .crawl:
        final crawlCubit = context.read<CrawlCubit>();
        return [
          // Direction ----------------------------------------------
          DirectionSelector(
            options: CrawlTextDirectionEnum.values,
            selectedDirection:
                (ledPanelBloc.state.config.animation as CrawlConfigModel)
                    .direction,
            onChanged: (direction) {
              crawlCubit.onDirectionChanged(direction);
              ledPanelBloc.add(
                LedPanelAnimationConfigChanged(crawlCubit.state.config),
              );
            },
          ),

          // Speed ----------------------------------------------
          NumericValueSelector(
            label: 'SPEED',
            unit: 'px/s',
            value: (ledPanelBloc.state.config.animation as CrawlConfigModel)
                .speed
                .round(),
            minValue: 20,
            maxValue: 500,
            incrementStep: 5,
            decrementStep: 5,
            onChanged: (speed) {
              crawlCubit.onSpeedChanged(speed.toDouble());
              ledPanelBloc.add(
                LedPanelAnimationConfigChanged(crawlCubit.state.config),
              );
            },
          ),

          // Tilt ----------------------------------------------
          NumericValueSelector(
            label: 'Tilt',
            unit: 'XD',
            value: (ledPanelBloc.state.config.animation as CrawlConfigModel)
                .tiltDegrees
                .round(),
            minValue: -90,
            maxValue: 90,
            incrementStep: 5,
            decrementStep: 5,
            onChanged: (tilt) {
              crawlCubit.onTiltChanged(tilt.toDouble());
              ledPanelBloc.add(
                LedPanelAnimationConfigChanged(crawlCubit.state.config),
              );
            },
          ),
        ];
    }
  }
}
