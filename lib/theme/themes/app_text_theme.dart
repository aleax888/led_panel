import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

/// Construye el [TextTheme] de la app a partir de los valores
/// definidos en [AppTypography] y [AppColors].
class AppTextTheme {
  AppTextTheme._();

  static final TextTheme light = _build(
    primaryColor: AppColors.textPrimaryLight,
    secondaryColor: AppColors.textSecondaryLight,
  );

  static final TextTheme dark = _build(
    primaryColor: AppColors.textPrimaryDark,
    secondaryColor: AppColors.textSecondaryDark,
  );

  static TextTheme _build({
    required Color primaryColor,
    required Color secondaryColor,
  }) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeDisplay,
        fontWeight: AppTypography.bold,
        height: AppTypography.lineHeightTight,
        letterSpacing: AppTypography.letterSpacingTight,
        color: primaryColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeHeadlineLg,
        fontWeight: AppTypography.bold,
        height: AppTypography.lineHeightTight,
        color: primaryColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeHeadlineMd,
        fontWeight: AppTypography.semiBold,
        height: AppTypography.lineHeightNormal,
        color: primaryColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeHeadlineSm,
        fontWeight: AppTypography.semiBold,
        height: AppTypography.lineHeightNormal,
        color: primaryColor,
      ),
      titleLarge: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeTitleLg,
        fontWeight: AppTypography.semiBold,
        height: AppTypography.lineHeightNormal,
        color: primaryColor,
      ),
      titleMedium: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeTitleMd,
        fontWeight: AppTypography.medium,
        height: AppTypography.lineHeightNormal,
        color: primaryColor,
      ),
      titleSmall: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeBodyMd,
        fontWeight: AppTypography.medium,
        height: AppTypography.lineHeightNormal,
        color: secondaryColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeBodyLg,
        fontWeight: AppTypography.regular,
        height: AppTypography.lineHeightRelaxed,
        color: primaryColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeBodyMd,
        fontWeight: AppTypography.regular,
        height: AppTypography.lineHeightRelaxed,
        color: secondaryColor,
      ),
      bodySmall: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeBodySm,
        fontWeight: AppTypography.regular,
        height: AppTypography.lineHeightNormal,
        color: secondaryColor,
      ),
      labelLarge: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeButton,
        fontWeight: AppTypography.semiBold,
        letterSpacing: AppTypography.letterSpacingButton,
        color: primaryColor,
      ),
      labelMedium: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeLabel,
        fontWeight: AppTypography.medium,
        letterSpacing: AppTypography.letterSpacingNormal,
        color: secondaryColor,
      ),
      labelSmall: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeCaption,
        fontWeight: AppTypography.regular,
        color: secondaryColor,
      ),
    );
  }
}
