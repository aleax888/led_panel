import 'package:flutter/material.dart';

/// Paleta de colores de la aplicación.
///
/// REGLA: ningún widget debe usar `Color(0xFF...)` directamente.
/// Todos los colores deben provenir de esta clase.
class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------
  // Colores de marca (basados en el gradiente #DCE35B -> #45B649)
  // ---------------------------------------------------------------------
  static const Color primary = Color(0xFF45B649);
  static const Color primaryLight = Color(0xFF6BC96E);
  static const Color primaryDark = Color(0xFF2E8A32);
  static const Color onPrimary = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFFDCE35B);
  static const Color secondaryLight = Color(0xFFE8ED8C);
  static const Color secondaryDark = Color(0xFFC0C93E);
  static const Color onSecondary = Color(0xFF1B1F16);

  /// Gradiente principal de marca (headers, botones destacados, splash, etc).
  static const List<Color> primaryGradient = [secondary, primary];

  // ---------------------------------------------------------------------
  // Colores semánticos
  // ---------------------------------------------------------------------
  static const Color success = Color(0xFF2E8A32);
  static const Color error = Color(0xFFD64545);
  static const Color warning = Color(0xFFE0A83E);
  static const Color info = Color(0xFF3E8FD6);

  // ---------------------------------------------------------------------
  // Neutros - Tema claro
  // ---------------------------------------------------------------------
  static const Color backgroundLight = Color(0xFFFAFAF5);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFF0F2E9);
  static const Color borderLight = Color(0xFFD8DED0);
  static const Color dividerLight = Color(0xFFE3E7DC);
  static const Color textPrimaryLight = Color(0xFF1B1F16);
  static const Color textSecondaryLight = Color(0xFF5C6355);
  static const Color textDisabledLight = Color(0xFFA3A99B);

  // ---------------------------------------------------------------------
  // Neutros - Tema oscuro
  // ---------------------------------------------------------------------
  static const Color backgroundDark = Color(0xFF121812);
  static const Color surfaceDark = Color(0xFF1E251E);
  static const Color surfaceVariantDark = Color(0xFF283029);
  static const Color borderDark = Color(0xFF394536);
  static const Color dividerDark = Color(0xFF323B2F);
  static const Color textPrimaryDark = Color(0xFFF2F5EC);
  static const Color textSecondaryDark = Color(0xFFB8C2AE);
  static const Color textDisabledDark = Color(0xFF5C6355);

  // ---------------------------------------------------------------------
  // Comunes
  // ---------------------------------------------------------------------
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;
  static const Color shadow = Color(0x33000000);
  static const Color overlay = Color(0x66000000);
  static const Color disabledButton = Color(0xFFC7CBC1);
}
