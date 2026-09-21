import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel/led_panel_bloc.dart';
import 'package:led_panel/bloc/led_panel_list/led_panel_list_bloc.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/presentation/pages/config_page.dart';
import 'package:led_panel/presentation/pages/display_page.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel.dart';
import 'package:led_panel/presentation/widgets/saved_config_item/delete_validation_dialog.dart';
import 'package:led_panel/presentation/widgets/saved_config_item/favorite_button.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/utils/app_date_formater.dart';

/// Displays a saved LED panel configuration with actions and a preview.
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
      padding: AppSpacing.cardPadding.copyWith(top: 0.0),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(
          color: context.colors.outline,
          width: AppSizes.borderWidthThin,
        ),
        borderRadius: AppRadius.borderRadiusLg,
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              // Date ----------------------------------------------
              Text(AppDateFormater.long(widget.config.createdAt)),

              // Fav button ----------------------------------------------
              FavoriteButton(
                isFavorite: widget.config.favorite,
                onChanged: _onFavorite,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .end,
            children: [
              // Config Preview ----------------------------------------------
              InkWell(
                onTap: _onLaunch,
                child: LedPanel(
                  config: widget.config.copyWithProportion(proportion),
                  panelWidth: fixedPanelWidth,
                  panelHeight: fixedPanelHeight,
                  borderRadius: AppRadius.borderRadiusLg,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: .end,
                  children: [
                    // Delete ----------------------------------------------
                    IconButton(onPressed: _onDelete, icon: Icon(Icons.delete)),

                    // Edit ----------------------------------------------
                    IconButton(
                      onPressed: _onEdit,
                      icon: Icon(Icons.edit_square),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onEdit() => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ConfigPage(initialConfig: widget.config),
    ),
  );

  Future<void> _onDelete() async {
    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (_) => const DeleteValidationDialog(),
    );

    if (mounted && confirmDelete == true) {
      context.read<LedPanelListBloc>().add(
        LedPanelListConfigDeleted(widget.config.id ?? ''),
      );
    }
  }

  void _onFavorite() {
    context.read<LedPanelListBloc>().add(LedPanelListFavorite(widget.config));
  }

  void _onLaunch() {
    context.read<LedPanelBloc>().add(LedPanelConfigSelected(widget.config));
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const DisplayPage()));
  }
}
