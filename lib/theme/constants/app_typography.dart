import 'package:flutter/material.dart';

/// Valores tipográficos constantes: familia de fuente, tamaños, pesos,
/// interlineado y espaciado entre letras.
class AppTypography {
  AppTypography._();

  // ---------------------------------------------------------------------
  // Familia de fuente
  // ---------------------------------------------------------------------
  static const String fontRoboto = 'Roboto';
  static const String fontIntelOneMono = 'IntelOneMono';
  static const String fontInter = 'Inter';
  static const String fontIrishGrover = 'IrishGrover';
  static const String fontItalianno = 'Italianno';
  static const String fontKarantina = 'Karantina';
  static const String fontPixelifySans = 'PixelifySans';
  static const String fontPoppins = 'Poppins';

  // ---------------------------------------------------------------------
  // Tamaños de fuente
  // ---------------------------------------------------------------------
  static const double sizeDisplay = 34;
  static const double sizeHeadlineLg = 28;
  static const double sizeHeadlineMd = 24;
  static const double sizeHeadlineSm = 20;
  static const double sizeTitleLg = 18;
  static const double sizeTitleMd = 16;
  static const double sizeBodyLg = 16;
  static const double sizeBodyMd = 14;
  static const double sizeBodySm = 12;
  static const double sizeLabel = 12;
  static const double sizeCaption = 11;
  static const double sizeOverline = 10;
  static const double sizeButton = 15;

  // ---------------------------------------------------------------------
  // Pesos de fuente
  // ---------------------------------------------------------------------
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight black = FontWeight.w900;

  // ---------------------------------------------------------------------
  // Interlineado (line-height relativo)
  // ---------------------------------------------------------------------
  static const double lineHeightTight = 1.15;
  static const double lineHeightNormal = 1.35;
  static const double lineHeightRelaxed = 1.5;

  // ---------------------------------------------------------------------
  // Espaciado entre letras
  // ---------------------------------------------------------------------
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0;
  static const double letterSpacingWide = 0.5;
  static const double letterSpacingWidest = 2;
  static const double letterSpacingUltra = 4;
  static const double letterSpacingButton = 0.4;
}
