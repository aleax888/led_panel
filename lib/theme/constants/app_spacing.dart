import 'package:flutter/material.dart';

/// Espaciados constantes de la aplicación.
///
/// Escala base de 4px para mantener consistencia en paddings,
/// margins y separaciones (gaps) entre elementos.
class AppSpacing {
  AppSpacing._();

  static const double none = 0;
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;

  // ---------------------------------------------------------------------
  // Paddings reutilizables
  // ---------------------------------------------------------------------
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: lg, vertical: sm);
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(horizontal: md, vertical: sm);
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(horizontal: md, vertical: xs);
}
