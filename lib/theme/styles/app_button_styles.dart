import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_sizes.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Estilos de los distintos tipos de botones de la app.
/// Todos los valores provienen de las clases de constantes
/// (AppColors, AppRadius, AppSizes, AppSpacing, AppTypography).
class AppButtonStyles {
  AppButtonStyles._();

  static const TextStyle _labelStyle = TextStyle(
    fontFamily: AppTypography.fontRoboto,
    fontSize: AppTypography.sizeButton,
    fontWeight: AppTypography.semiBold,
    letterSpacing: AppTypography.letterSpacingButton,
  );

  /// Botón principal (acción primaria de la pantalla).
  static ElevatedButtonThemeData get elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        disabledBackgroundColor: AppColors.disabledButton,
        disabledForegroundColor: AppColors.textDisabledLight,
        minimumSize: const Size(AppSizes.buttonMinWidth, AppSizes.buttonHeightMd),
        padding: AppSpacing.buttonPadding,
        elevation: AppSizes.elevationSm,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusLg),
        textStyle: _labelStyle,
      ),
    );
  }

  /// Botón secundario (acción alternativa, menos peso visual).
  static OutlinedButtonThemeData get outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        disabledForegroundColor: AppColors.textDisabledLight,
        minimumSize: const Size(AppSizes.buttonMinWidth, AppSizes.buttonHeightMd),
        padding: AppSpacing.buttonPadding,
        side: const BorderSide(color: AppColors.primary, width: AppSizes.borderWidthMedium),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusMd),
        textStyle: _labelStyle,
      ),
    );
  }

  /// Botón terciario (acciones de bajo énfasis, tipo "Cancelar").
  static TextButtonThemeData get textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        disabledForegroundColor: AppColors.textDisabledLight,
        minimumSize: const Size(AppSizes.buttonMinWidth, AppSizes.buttonHeightSm),
        padding: AppSpacing.buttonPadding,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusSm),
        textStyle: _labelStyle,
      ),
    );
  }

  /// Botón flotante de acción (FAB).
  static FloatingActionButtonThemeData get floatingActionButtonTheme {
    return const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      elevation: AppSizes.elevationMd,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusLg),
    );
  }
}
