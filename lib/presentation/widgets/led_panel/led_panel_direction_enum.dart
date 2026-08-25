import 'package:flutter/material.dart';

/// Direction in which the content of a [LedPanel] moves.
enum LedPanelDirectionEnum { toLeft, toRight }

extension LedPanelDirectionExtension on LedPanelDirectionEnum {
  /// Icon associated with the movement direction.
  IconData get icon {
    switch (this) {
      case .toLeft:
        return Icons.arrow_back_rounded;
      case .toRight:
        return Icons.arrow_forward_rounded;
    }
  }

  /// Human-readable name shown in the interface.
  String get name {
    switch (this) {
      case .toLeft:
        return 'Left';
      case .toRight:
        return 'Right';
    }
  }

  /// Offset multiplier.
  double get multiplier {
    switch (this) {
      case .toLeft:
        return -1;
      case .toRight:
        return 1;
    }
  }

  /// Overflow alignment.
  Alignment get alignment {
    switch (this) {
      case .toLeft:
        return const Alignment(-1, 0);
      case .toRight:
        return const Alignment(1, 0);
    }
  }
}
