import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/led_panel/led_panel_bloc.dart';
import 'package:led_panel/bloc/led_panel_list/led_panel_list_bloc.dart';
import 'package:led_panel/data/models/led_panel/led_panel_config_model.dart';
import 'package:led_panel/presentation/pages/aux_config_page.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/presentation/pages/display_page.dart';
import 'package:led_panel/presentation/widgets/led_panel/led_panel.dart';
import 'package:led_panel/presentation/widgets/saved_config_item/delete_validation_dialog.dart';
import 'package:led_panel/presentation/widgets/saved_config_item/favorite_button.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/utils/app_date_formater.dart';
import 'package:led_panel/utils/panel_size_handler.dart';

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
    final fixedDimensions = PanelSizehandler.getFixedDimensions(
      context,
      AppSpacing.screenPadding,
      2.5,
    );
    return Container(
      padding: AppSpacing.cardPadding.copyWith(bottom: 0.0),
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
          LayoutBuilder(
            builder: (context, constraints) => Row(
              children: [
                // Config Preview ----------------------------------------------
                InkWell(
                  onTap: _onLaunch,
                  child: LedPanel(
                    config: widget.config.copyWithProportion(
                      fixedDimensions.proportion,
                    ),
                    panelWidth: constraints.maxWidth,
                    panelHeight: fixedDimensions.height,
                    borderRadius: AppRadius.borderRadiusMd,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              // Date ----------------------------------------------
              Expanded(
                child: Text(AppDateFormater.long(widget.config.createdAt)),
              ),

              Row(
                children: [
                  // Delete ----------------------------------------------
                  IconButton(
                    onPressed: _onDelete,
                    icon: Icon(Icons.delete_outline),
                  ),

                  // Edit ----------------------------------------------
                  IconButton(
                    onPressed: _onEdit,
                    icon: Icon(Icons.edit_outlined),
                  ),

                  SizedBox(
                    height: AppSizes.avatarSm,
                    child: VerticalDivider(
                      radius: AppRadius.borderRadiusLg,
                      indent: AppSpacing.sm,
                      endIndent: AppSpacing.sm,
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),

                  // Fav button ----------------------------------------------
                  FavoriteButton(
                    isFavorite: widget.config.favorite,
                    onChanged: _onFavorite,
                  ),
                ],
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
      builder: (context) => AuxConfigPage(initialConfig: widget.config),
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
