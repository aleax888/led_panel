/// Enum representing different shapes for LED dots.
enum DotShapeEnum {
  /// Circle shape
  circle(label: 'Circle', asset: 'assets/images/led_shapes/circle.png'),

  /// Square shape
  square(label: 'Square', asset: 'assets/images/led_shapes/square.png'),

  /// Diamond shape
  diamond(label: 'Diamond', asset: 'assets/images/led_shapes/diamond.png'),

  /// Star shape
  star(label: 'Star', asset: 'assets/images/led_shapes/star.png'),

  /// Cross shape
  cross(label: 'Cross', asset: 'assets/images/led_shapes/cross.png'),

  /// Heart shape
  heart(label: 'Heart', asset: 'assets/images/led_shapes/heart.png');

  const DotShapeEnum({required this.label, required this.asset});

  /// The human-readable label for the dot shape.
  final String label;
  /// This label can be used in the UI to represent the shape.
  final String asset;
}
