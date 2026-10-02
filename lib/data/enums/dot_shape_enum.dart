/// Enum representing different shapes for LED dots.
enum DotShapeEnum {
  /// Circle shape
  circle(label: 'Circle', asset: ''),

  /// Square shape
  square(label: 'Square', asset: ''),

  /// Diamond shape
  diamond(label: 'Diamond', asset: ''),

  /// Star shape
  star(label: 'Star', asset: ''),

  /// Cross shape
  cross(label: 'Cross', asset: ''),

  /// Heart shape
  heart(label: 'Heart', asset: '');

  const DotShapeEnum({required this.label, required this.asset});

  /// The human-readable label for the dot shape.
  final String label;
  /// This label can be used in the UI to represent the shape.
  final String asset;
}
