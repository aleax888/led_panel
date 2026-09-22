enum DotShapeEnum { circle, square, diamond, star, cross, heart }

extension DotShapeEnumExtension on DotShapeEnum {
  /// Human-readable name shown in the interface.
  String get label {
    switch (this) {
      case .circle:
        return 'Circle';
      case .square:
        return 'Square';
      case .diamond:
        return 'Diamond';
      case .star:
        return 'Star';
      case .cross:
        return 'Cross';
      case .heart:
        return 'Heart';
    }
  }

  /// Path to the corresponding animation asset.
  String get asset {
    switch (this) {
      case .circle:
        return '';
      case .square:
        return '';
      case .diamond:
        return '';
      case .star:
        return '';
      case .cross:
        return '';
      case .heart:
        return '';
    }
  }
}
