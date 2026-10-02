import 'dart:ui';

/// Class that represents a single gradient stop, which consists of a position (0-100) and a color.
class GradientStop {
  /// The position of the gradient stop, represented as a percentage (0-100).
  final int position;
  /// The color of the gradient stop.
  final Color color;

  const GradientStop({required this.position, required this.color})
    : assert(position >= 0 && position <= 100);

  GradientStop copyWith({int? position, Color? color}) => GradientStop(
    position: position ?? this.position,
    color: color ?? this.color,
  );
}
