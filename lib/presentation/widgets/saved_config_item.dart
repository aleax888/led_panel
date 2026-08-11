import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel/led_panel_bloc.dart';
import 'package:led_panel/bloc/led_panel_list/led_panel_list_bloc.dart';
import 'package:led_panel/data/led_panel_config_model.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/presentation/pages/config_page.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

class SavedConfigItem extends StatefulWidget {
  final LedPanelConfigModel config;
  const SavedConfigItem({super.key, required this.config});

  @override
  State<SavedConfigItem> createState() => _SavedConfigItemState();
}

class _SavedConfigItemState extends State<SavedConfigItem> {
  @override
  Widget build(BuildContext context) {
    final double fixedRelation = 2;
    final double fixedPanelWidth =
        (context.screenSize.width - AppSpacing.screenPadding.horizontal) /
        fixedRelation;
    final double fixedPanelHeight =
        (((context.screenSize.width - AppSpacing.screenPadding.horizontal) *
                context.screenSize.width) /
            context.screenSize.height) /
        fixedRelation;
    final double proportion = fixedPanelWidth / context.screenSize.height;
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(
          color: context.colors.outline,
          width: AppSizes.borderWidthThin,
        ),
        borderRadius: AppRadius.borderRadiusLg,
      ),
      child: Column(
        spacing: AppSpacing.md,
        crossAxisAlignment: .start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              LedPanel(
                config: widget.config.copyWithProportion(proportion),
                panelWidth: fixedPanelWidth,
                panelHeight: fixedPanelHeight,
                borderRadius: AppRadius.borderRadiusLg,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: .end,
                  children: [
                    IconButton(
                      onPressed: _onEdit,
                      icon: Icon(Icons.edit_square),
                    ),
                    IconButton(onPressed: _onDelete, icon: Icon(Icons.delete)),
                  ],
                ),
              ),
            ],
          ),
          Text(widget.config.createdAt?.toString() ?? "Unknow"),
        ],
      ),
    );
  }

  void _onEdit() {
    final LedPanelBloc ledPanelBloc = context.read<LedPanelBloc>();
    ledPanelBloc.add(LedPanelConfigSelected(widget.config));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConfigPage()),
    );
  }

  void _onDelete() {
    final LedPanelListBloc ledPanelListBloc = context.read<LedPanelListBloc>();
    ledPanelListBloc.add(LedPanelListConfigDeleted(widget.config.id ?? ''));
  }
}
