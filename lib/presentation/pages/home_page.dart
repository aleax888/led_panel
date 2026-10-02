import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel_list/led_panel_list_bloc.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';
import 'package:led_panel/presentation/pages/aux_config_page.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/multi_tabs_view.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/scrollable_tab.dart';
import 'package:led_panel/presentation/widgets/saved_config_item/saved_config_item.dart';
import 'package:led_panel/presentation/widgets/side_menu/side_menu.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/utils/toast_handler.dart';

// Home page.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final LedPanelListBloc ledPanelListBloc = context.read<LedPanelListBloc>();
    ledPanelListBloc.add(LedPanelListOpened());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedPanelListBloc, LedPanelListState>(
      builder: (context, state) {
        return Scaffold(
          drawer: SideMenu(),
          appBar: AppBar(
            title: Text(
              context.locale.home,
              style: context.textTheme.labelLarge,
            ),
          ),
          body: SafeArea(
            child: state.isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    spacing: AppSpacing.md,
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    children: [
                      SizedBox(),

                      Padding(
                        padding: AppSpacing.screenPadding,
                        child: Row(
                          spacing: AppSpacing.xs,
                          children: [
                            // New Configuration Button ----------------------------------------------
                            Expanded(
                              flex: 5,
                              child: SizedBox(
                                height: AppSizes.buttonHeightXl,
                                child: ElevatedButton(
                                  onPressed: () => _goToConfig(),
                                  child: Text(
                                    context.locale.newConfig,
                                    style: context.textTheme.headlineLarge
                                        ?.copyWith(
                                          color: context.colors.onPrimary,
                                        ),
                                  ),
                                ),
                              ),
                            ),

                            // Import Configuration Button ----------------------------------------------
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: AppSizes.buttonHeightXl,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: () async {
                                    try {
                                      final config =
                                          LedPanelConfigModel.fromJson(
                                            jsonDecode(
                                              await showDialog<String?>(
                                                    context: context,
                                                    builder: (_) =>
                                                        _ImportConfigDialog(),
                                                  ) ??
                                                  '',
                                            ),
                                          );
                                      _goToConfig(config);
                                    } catch (e) {
                                      if (mounted) {
                                        ToastHandler.showError(
                                          context.locale.importError,
                                        );
                                      }
                                    }
                                  },
                                  child: Icon(
                                    Icons.import_export_outlined,
                                    size: context
                                        .textTheme
                                        .headlineLarge
                                        ?.fontSize,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Configurations List ----------------------------------------------
                      Expanded(
                        child: Container(
                          padding: AppSpacing.screenPadding,
                          child: MultiTabsView(
                            tabNames: [
                              context.locale.recents,
                              context.locale.favorites,
                            ],
                            tabViews: [
                              // Recents ----------------------------------------------
                              ScrollableTab(
                                children: state.configList
                                    .where((e) => !e.favorite)
                                    .map(
                                      (e) => SavedConfigItem(
                                        key: ValueKey(e.id),
                                        config: e,
                                      ),
                                    )
                                    .toList(),
                              ),

                              // Favorities ----------------------------------------------
                              ScrollableTab(
                                children: state.configList
                                    .where((e) => e.favorite)
                                    .map(
                                      (e) => SavedConfigItem(
                                        key: ValueKey(e.id),
                                        config: e,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
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

  void _goToConfig([LedPanelConfigModel? initialConfig]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuxConfigPage(initialConfig: initialConfig),
      ),
    );
  }
}

/// Displays a dialog for importing configuration.
class _ImportConfigDialog extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  _ImportConfigDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.locale.fromNetwork,
        style: context.textTheme.titleMedium,
      ),
      content: TextFormField(
        controller: controller,
        onEditingComplete: () => Focus.of(context).unfocus(),
        onTapOutside: (event) => Focus.of(context).unfocus(),
        maxLines: 2,
        minLines: 1,
        decoration: InputDecoration(hintText: context.locale.pasteTheConfig),
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      actions: [
        // Cancel ----------------------------------------------
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text(
            context.locale.cancel,
            style: context.textTheme.labelLarge,
          ),
        ),

        // Import ----------------------------------------------
        ElevatedButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: Text(
            context.locale.done,
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colors.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
