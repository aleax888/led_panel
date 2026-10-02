import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/theme/theme_cubit.dart';
import 'package:led_panel/presentation/widgets/locale_selector/locale_selection_dialog.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/presentation/widgets/app_version.dart';
import 'package:led_panel/presentation/widgets/side_menu/side_menu_option.dart';
import 'package:led_panel/presentation/widgets/side_menu/side_menu_switch_option.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/utils/share_handler.dart';

/// Side menu.
class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppRadius.lg),
          bottomRight: Radius.circular(AppRadius.lg),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Header ----------------------------------------------
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text('LED PANEL', style: context.textTheme.displayLarge),
                    AppVersion(),
                  ],
                ),
              ),
              Divider(height: AppSpacing.md),

              // Language ----------------------------------------------
              SideMenuOption(
                icon: Icons.language_outlined,
                label: 'LANGUAGE',
                onTap: () async => await showDialog<Color>(
                  context: context,
                  builder: (_) => LocaleSelectionDialog(),
                ),
              ),

              // Share App  ----------------------------------------------
              SideMenuOption(
                icon: Icons.share_outlined,
                label: 'SHARE APP',
                onTap: () => ShareHandler.shareUri(
                  Uri.https('github.com', '/aleax888/led_panel'),
                ),
              ),

              // Theme Switch ----------------------------------------------
              SideMenuSwitchOption(
                value: context.theme.brightness == Brightness.dark,
                icon: context.theme.brightness == Brightness.dark
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                onChanged: (bool value) =>
                    context.read<ThemeCubit>().switchThemeMode(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
