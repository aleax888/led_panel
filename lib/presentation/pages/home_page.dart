import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel_list/led_panel_list_bloc.dart';
import 'package:led_panel/presentation/pages/config_page.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/multi_tabs_view.dart';
import 'package:led_panel/presentation/widgets/multi_tabs/scrollable_tab.dart';
import 'package:led_panel/presentation/widgets/saved_config_item/saved_config_item.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

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
          appBar: AppBar(title: const Text('Home')),
          body: SafeArea(
            child: state.isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    spacing: AppSpacing.md,
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    children: [
                      SizedBox(),
                      Container(
                        width: .infinity,
                        height: AppSizes.buttonHeightXl,
                        padding: AppSpacing.screenPadding,
                        child: ElevatedButton(
                          onPressed: () => _goToConfig(),
                          child: Text('+ NEW'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: AppSpacing.screenPadding,
                          child: MultiTabsView(
                            tabNames: ['RECIENTES', 'FAVORITOS'],
                            tabViews: [
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
                      SizedBox(),
                    ],
                  ),
          ),
        );
      },
    );
  }

  void _goToConfig() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConfigPage()),
    );
  }
}
