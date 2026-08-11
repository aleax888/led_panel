import 'package:flutter/material.dart';

/// Dirección en la que se desplaza el contenido de un [LedPanel].
enum LedPanelDirectionEnum { toLeft, toRight }

extension LedPanelDirectionExtension on LedPanelDirectionEnum {
  /// Icono asociado al sentido de desplazamiento.
  IconData get icon {
    switch (this) {
      case .toLeft:
        return Icons.arrow_back_rounded;
      case .toRight:
        return Icons.arrow_forward_rounded;
    }
  }

  /// Nombre legible para mostrar en la interfaz.
  String get name {
    switch (this) {
      case .toLeft:
        return 'Izquierda';
      case .toRight:
        return 'Derecha';
    }
  }

  /// Multiplicador de offset
  double get multiplier {
    switch (this) {
      case .toLeft:
        return -1;
      case .toRight:
        return 1;
    }
  }

  /// Alineación de overflow
  Alignment get alignment {
    switch (this) {
      case .toLeft:
        return const Alignment(-1, 0);
      case .toRight:
        return const Alignment(1, 0);
    }
  }
}
