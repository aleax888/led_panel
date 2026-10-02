import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:led_panel/bloc/led_panel/led_panel_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel_list/led_panel_list_bloc.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';
import 'package:led_panel/presentation/widgets/app_icon_button.dart';
import 'package:led_panel/presentation/widgets/fields/leds_fields.dart';
import 'package:led_panel/presentation/widgets/fields/text_fields.dart';

import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/presentation/pages/display_page.dart';
import 'package:led_panel/presentation/widgets/animation_selector/animation_selector.dart';
import 'package:led_panel/presentation/widgets/background_selector.dart/background_selector.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/multi_tabs_view.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/separated_list_tab.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/utils/panel_size_handler.dart';
import 'package:led_panel/utils/share_handler.dart';
import 'package:led_panel/utils/widget_capture_handler.dart';

/// A page that allows users to customize the configuration of an LED panel, including text, animation, background, and LED settings. It provides a preview of the LED panel and options to save or share the configuration.
class ConfigPage extends StatefulWidget {
  final LedPanelConfigModel? initialConfig;
  const ConfigPage({super.key, this.initialConfig});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 4,
    vsync: this,
  );
  final FocusNode _messageFocusNode = FocusNode();
  final TextFields _textFields = TextFields();
  final LedsFields _ledsFields = LedsFields();
  final _ledPanelKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    final LedPanelBloc ledPanelBloc = context.read<LedPanelBloc>();
    ledPanelBloc.add(LedPanelConfigSelected(widget.initialConfig));
  }

  @override
  void deactivate() {
    _saveConfig(updateSelectedConfig: false);
    context.read<LedPanelBloc>().add(LedPanelUnselected());
    super.deactivate();
  }

  @override
  void dispose() {
    _messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LedPanelBloc ledPanelBloc = context.read<LedPanelBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text('CUSTOMIZATION', style: context.textTheme.labelLarge),
      ),
      body: SafeArea(
        child: Column(
          spacing: AppSpacing.md,
          children: [
            SizedBox(),

            Container(
              margin: AppSpacing.screenPadding,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      _tabController.animateTo(0);
                      _messageFocusNode.requestFocus();
                    },
                    child: BlocBuilder<LedPanelBloc, LedPanelState>(
                      builder: (context, state) {
                        final fixedDimensions =
                            PanelSizehandler.getFixedDimensions(
                              context,
                              AppSpacing.screenPadding,
                            );
                        // Led Panel Preview ----------------------------------------------
                        return RepaintBoundary(
                          key: _ledPanelKey,
                          child: LedPanel(
                            panelWidth: fixedDimensions.width,
                            panelHeight: fixedDimensions.height,
                            borderRadius: AppRadius.borderRadiusLg,
                            config: state.config.copyWithProportion(
                              fixedDimensions.proportion,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: AppSpacing.xs,
                    top: AppSpacing.xs,
                    child: Row(
                      spacing: AppSpacing.xs,
                      children: [
                        // Share Button ----------------------------------------------
                        AppIconButton(
                          icon: Icons.share_outlined,
                          onPressed: () async {
                            final file = await WidgetCaptureHandler.toXFile(
                              _ledPanelKey,
                            );
                            if (file != null) {
                              await ShareHandler.shareFiles(
                                [file],
                                text: jsonEncode(
                                  ledPanelBloc.state.config.toJson(),
                                ),
                              );
                            }
                          },
                        ),
                        // Play Button ----------------------------------------------
                        AppIconButton(
                          icon: Icons.open_in_full_rounded,
                          onPressed: _navigateToDisplay,
                        ),
                      ],
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
                  controller: _tabController,
                  tabNames: ['TEXT', 'ANIM', 'BG', 'LEDs'],
                  tabViews: [
                    SeparatedListTab(
                      children: [
                        // Text Config ----------------------------------------------
                        ..._textFields.build(
                          context,
                          _messageFocusNode,
                          (config) => ledPanelBloc.add(
                            LedPanelTextConfigChanged(config),
                          ),
                        ),
                      ],
                    ),
                    SeparatedListTab(
                      children: [
                        // Animation Type ----------------------------------------------
                        AnimationSelector(
                          selectedAnimation: context
                              .watch<LedPanelBloc>()
                              .state
                              .config
                              .animation
                              .type,
                          onChanged: (animationType) => ledPanelBloc.add(
                            LedPanelAnimationTypeChanged(
                              animationType.fields.currentConfig(context),
                            ),
                          ),
                        ),

                        // Animation Config ----------------------------------------------
                        ...ledPanelBloc.state.config.animation.type.fields
                            .build(
                              context,
                              (config) => ledPanelBloc.add(
                                LedPanelAnimationConfigChanged(config),
                              ),
                            ),
                      ],
                    ),
                    SeparatedListTab(
                      children: [
                        // Background Type ----------------------------------------------
                        BackgroundSelector(
                          selectedBackground: context
                              .watch<LedPanelBloc>()
                              .state
                              .config
                              .background
                              .type,
                          onChanged: (backgroundType) => ledPanelBloc.add(
                            LedPanelBackgroundTypeChanged(
                              backgroundType.fields.currentConfig(context),
                            ),
                          ),
                        ),

                        // Background Config ----------------------------------------------
                        ...ledPanelBloc.state.config.background.type.fields
                            .build(
                              context,
                              (config) => ledPanelBloc.add(
                                LedPanelBackgroundConfigChanged(config),
                              ),
                            ),
                      ],
                    ),
                    SeparatedListTab(
                      children: [
                        // Leds Config ----------------------------------------------
                        ..._ledsFields.build(
                          context,
                          (config) => ledPanelBloc.add(
                            LedPanelLedsConfigChanged(config),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
