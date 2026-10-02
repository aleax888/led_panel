import 'package:led_panel/theme/constants/app_sizes.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';

/// Medidas del editor de degradado. Todas derivan de unas pocas constantes,
/// así que ajustar una (p. ej. [thumbHeight]) reacomoda el resto.
abstract final class GradientEditorMetrics {
  static const double focusScale = 1.25;

  // Thumb
  static const double thumbHeight = AppSizes.buttonHeightMd;
  static const double thumbWidth = thumbHeight / 2;

  /// Margen superior para que el thumb escalado no se recorte.
  static const double thumbTop = thumbHeight * (focusScale - 1) / 2;

  // Pista: centrada verticalmente respecto al thumb.
  static const double trackHeight = AppSizes.buttonHeightSm;
  static const double trackTop = thumbTop + (thumbHeight - trackHeight) / 2;

  // Etiqueta: debajo del thumb.
  static const double labelWidth = 44;
  static const double labelHeight = 24;
  static const double labelTop = thumbTop + thumbHeight + AppSpacing.xs;

  /// Alto total del editor: termina donde acaba la etiqueta.
  static const double height = labelTop + labelHeight;
}
