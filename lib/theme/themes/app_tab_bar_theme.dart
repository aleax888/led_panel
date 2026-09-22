import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_typography.dart';

/// Theme de la barra de pestañas.
class AppTabBarTheme {
  AppTabBarTheme._();

  static final TabBarThemeData light = _build(
    indicatorColor: AppColors.primary,
    labelColor: AppColors.onPrimary,
    unselectedLabelColor: AppColors.textPrimaryLight,
  );

  static final TabBarThemeData dark = _build(
    indicatorColor: AppColors.primaryLight,
    labelColor: AppColors.black,
    unselectedLabelColor: AppColors.textPrimaryDark,
  );

  static TabBarThemeData _build({
    required Color indicatorColor,
    required Color labelColor,
    required Color unselectedLabelColor,
  }) {
    return TabBarThemeData(
      indicator: BoxDecoration(
        color: indicatorColor,
        borderRadius: AppRadius.borderRadiusMd,
      ),
      dividerColor: Colors.transparent,
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      labelStyle: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeBodyMd,
        fontWeight: AppTypography.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: AppTypography.fontRoboto,
        fontSize: AppTypography.sizeBodyMd,
        fontWeight: AppTypography.medium,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }
}
