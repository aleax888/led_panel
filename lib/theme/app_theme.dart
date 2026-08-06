import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_opacity.dart';
import 'styles/app_button_styles.dart';
import 'constants/app_colors.dart';
import 'themes/app_input_theme.dart';
import 'constants/app_radius.dart';
import 'constants/app_sizes.dart';
import 'constants/app_spacing.dart';
import 'themes/app_text_theme.dart';
import 'themes/app_tab_bar_theme.dart';
import 'constants/app_typography.dart';

/// Punto único de acceso al theme de la aplicación.
class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(isDark: false);
  static ThemeData get dark => _build(isDark: true);

  static ThemeData _build({required bool isDark}) {
    final TextTheme textTheme = isDark ? AppTextTheme.dark : AppTextTheme.light;
    final ColorScheme colorScheme = isDark
        ? _darkColorScheme
        : _lightColorScheme;
    final Color background = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final Color surface = isDark
        ? AppColors.surfaceDark
        : AppColors.surfaceLight;
    final Color divider = isDark
        ? AppColors.dividerDark
        : AppColors.dividerLight;
    final Color textPrimary = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: AppTypography.fontRoboto,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      dividerColor: divider,
      textTheme: textTheme,

      // ---------------------------------------------------------------
      // AppBar
      // ---------------------------------------------------------------
      appBarTheme: AppBarThemeData(
        backgroundColor: surface,
        foregroundColor: textPrimary,
        elevation: AppSizes.elevationNone,
        centerTitle: true,
        toolbarHeight: AppSizes.appBarHeight,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: IconThemeData(color: textPrimary, size: AppSizes.iconMd),
      ),

      // ---------------------------------------------------------------
      // Botones
      // ---------------------------------------------------------------
      elevatedButtonTheme: AppButtonStyles.elevatedButtonTheme,
      outlinedButtonTheme: AppButtonStyles.outlinedButtonTheme,
      textButtonTheme: AppButtonStyles.textButtonTheme,
      floatingActionButtonTheme: AppButtonStyles.floatingActionButtonTheme,

      // ---------------------------------------------------------------
      // Inputs
      // ---------------------------------------------------------------
      inputDecorationTheme: isDark ? AppInputTheme.dark : AppInputTheme.light,
      tabBarTheme: isDark ? AppTabBarTheme.dark : AppTabBarTheme.light,

      // ---------------------------------------------------------------
      // Cards
      // ---------------------------------------------------------------
      cardTheme: CardThemeData(
        color: surface,
        elevation: AppSizes.elevationSm,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.borderRadiusMd,
        ),
      ),

      // ---------------------------------------------------------------
      // Divisores
      // ---------------------------------------------------------------
      dividerTheme: DividerThemeData(
        color: divider,
        thickness: AppSizes.dividerThickness,
        space: AppSpacing.md,
      ),

      // ---------------------------------------------------------------
      // Íconos
      // ---------------------------------------------------------------
      iconTheme: IconThemeData(color: textPrimary, size: AppSizes.iconMd),

      // ---------------------------------------------------------------
      // Chips
      // ---------------------------------------------------------------
      chipTheme: ChipThemeData(
        backgroundColor: isDark
            ? AppColors.surfaceVariantDark
            : AppColors.surfaceVariantLight,
        labelStyle: textTheme.labelMedium!,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.borderRadiusFull,
        ),
        side: BorderSide.none,
      ),

      // ---------------------------------------------------------------
      // SnackBar
      // ---------------------------------------------------------------
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark
            ? AppColors.surfaceVariantDark
            : AppColors.textPrimaryLight,
        contentTextStyle: const TextStyle(
          fontFamily: AppTypography.fontRoboto,
          fontSize: AppTypography.sizeBodyMd,
          color: AppColors.white,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.borderRadiusSm,
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // ---------------------------------------------------------------
      // Slider
      // ---------------------------------------------------------------
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: isDark
            ? AppColors.borderDark
            : AppColors.borderLight,
        thumbColor: colorScheme.primary,
        overlayColor: colorScheme.primary.withAlpha(AppOpacity.subtle),
        valueIndicatorColor: colorScheme.primary,
        valueIndicatorTextStyle: textTheme.labelMedium?.copyWith(
          color: AppColors.white,
        ),
        trackHeight: AppSizes.sliderTrackHeight,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: AppSizes.sliderThumbRadius,
        ),
        overlayShape: const RoundSliderOverlayShape(
          overlayRadius: AppSizes.sliderOverlayRadius,
        ),
      ),

      // ---------------------------------------------------------------
      // Diálogos
      // ---------------------------------------------------------------
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.borderRadiusLg,
        ),
        titleTextStyle: textTheme.headlineSmall,
        contentTextStyle: textTheme.bodyMedium,
      ),
    );
  }

  // -----------------------------------------------------------------------
  // ColorScheme
  // -----------------------------------------------------------------------
  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: AppColors.textPrimaryLight,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    secondaryContainer: AppColors.secondaryLight,
    onSecondaryContainer: AppColors.textPrimaryLight,
    error: AppColors.error,
    onError: AppColors.white,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimaryLight,
    outline: AppColors.borderLight,
    shadow: AppColors.shadow,
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryLight,
    onPrimary: AppColors.black,
    primaryContainer: AppColors.primaryDark,
    onPrimaryContainer: AppColors.textPrimaryDark,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    secondaryContainer: AppColors.secondaryDark,
    onSecondaryContainer: AppColors.textPrimaryDark,
    error: AppColors.error,
    onError: AppColors.white,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    outline: AppColors.borderDark,
    shadow: AppColors.shadow,
  );
}
