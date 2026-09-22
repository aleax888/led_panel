import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_panel/bloc/theme/theme_cubit.dart';
import 'package:led_panel/extensions/context_extension.dart';
import 'package:led_panel/presentation/widgets/side_menu/side_menu_option.dart';
import 'package:led_panel/presentation/widgets/side_menu/side_menu_switch_option.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

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
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Text('LED PANEL', style: context.textTheme.displayLarge),
                    Text('v', style: context.textTheme.labelLarge),
                  ],
                ),
              ),
              Divider(height: AppSpacing.md),
              SideMenuOption(
                icon: Icons.language_outlined,
                label: 'LANGUAGE',
                onTap: () {},
              ),
              SideMenuOption(
                icon: Icons.delete_outline,
                label: 'TRASH',
                onTap: () {},
              ),
              SideMenuOption(
                icon: Icons.share_outlined,
                label: 'SHARE',
                onTap: () {},
              ),
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
