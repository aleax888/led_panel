import 'package:flutter/material.dart';

import 'package:led_panel/bloc/led_panel/led_panel_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel_list/led_panel_list_bloc.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';
import 'package:led_panel/presentation/widgets/fields/background_fields.dart';
import 'package:led_panel/presentation/widgets/fields/leds_fields.dart';
import 'package:led_panel/presentation/widgets/fields/text_fields.dart';

import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/presentation/pages/display_page.dart';
import 'package:led_panel/presentation/widgets/animation_selector/animation_selector.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/multi_tabs_view.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/separated_list_tab.dart';
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

class _ConfigPageState extends State<ConfigPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );
  final FocusNode _messageFocusNode = FocusNode();
  final TextFields _textFields = TextFields();
  final BackgroundFields _backgroundFields = BackgroundFields();
  final LedsFields _ledsFields = LedsFields();

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
            // Led Panel Preview ----------------------------------------------
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
                        final double fixedPanelWidth =
                            context.screenSize.width -
                            AppSpacing.screenPadding.horizontal;
                        final double fixedPanelHeight =
                            ((context.screenSize.width -
                                    AppSpacing.screenPadding.horizontal) *
                                context.screenSize.width) /
                            context.screenSize.height;
                        final double proportion =
                            fixedPanelWidth / context.screenSize.height;
                        return LedPanel(
                          panelWidth: fixedPanelWidth,
                          panelHeight: fixedPanelHeight,
                          borderRadius: AppRadius.borderRadiusLg,
                          config: state.config.copyWithProportion(proportion),
                        );
                      },
                    ),
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
                  controller: _tabController,
                  tabNames: ['Text', 'Anim', 'BG'],
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
                        // Background Config ----------------------------------------------
                        ..._backgroundFields.build(
                          context,
                          (config) => ledPanelBloc.add(
                            LedPanelBackgroundConfigChanged(config),
                          ),
                        ),

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
