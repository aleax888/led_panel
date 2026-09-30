import 'dart:ui';

class GradientStop {
  final int position;
  final Color color;

  const GradientStop({required this.position, required this.color})
    : assert(position >= 0 && position <= 100);

  GradientStop copyWith({int? position, Color? color}) => GradientStop(
    position: position ?? this.position,
    color: color ?? this.color,
  );
}
