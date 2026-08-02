import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'constants/app_radius.dart';
import 'constants/app_sizes.dart';
import 'constants/app_spacing.dart';
import 'constants/app_typography.dart';

/// Theme de los campos de texto (TextField / TextFormField).
class AppInputTheme {
  AppInputTheme._();

  static final InputDecorationTheme light = _build(
    fillColor: AppColors.surfaceLight,
    borderColor: AppColors.borderLight,
    hintColor: AppColors.textSecondaryLight,
    labelColor: AppColors.textPrimaryLight,
  );

  static final InputDecorationTheme dark = _build(
    fillColor: AppColors.surfaceVariantDark,
    borderColor: AppColors.borderDark,
    hintColor: AppColors.textSecondaryDark,
    labelColor: AppColors.textPrimaryDark,
  );

  static InputDecorationTheme _build({
    required Color fillColor,
    required Color borderColor,
    required Color hintColor,
    required Color labelColor,
  }) {
    final OutlineInputBorder baseBorder = OutlineInputBorder(
      borderRadius: AppRadius.borderRadiusMd,
      borderSide: BorderSide(color: borderColor, width: AppSizes.borderWidthThin),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      contentPadding: AppSpacing.inputPadding,
      border: baseBorder,
      enabledBorder: baseBorder,
      focusedBorder: baseBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.primary, width: AppSizes.borderWidthThick),
      ),
      errorBorder: baseBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.error, width: AppSizes.borderWidthThin),
      ),
      focusedErrorBorder: baseBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.error, width: AppSizes.borderWidthThick),
      ),
      disabledBorder: baseBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.disabledButton, width: AppSizes.borderWidthThin),
      ),
      hintStyle: TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppTypography.sizeBodyMd,
        color: hintColor,
      ),
      labelStyle: TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppTypography.sizeBodyMd,
        color: labelColor,
      ),
      errorStyle: const TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppTypography.sizeCaption,
        color: AppColors.error,
      ),
    );
  }
}
