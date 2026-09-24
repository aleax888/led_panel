enum DotShapeEnum {
  circle(label: 'Circle', asset: ''),
  square(label: 'Square', asset: ''),
  diamond(label: 'Diamond', asset: ''),
  star(label: 'Star', asset: ''),
  cross(label: 'Cross', asset: ''),
  heart(label: 'Heart', asset: '');

  const DotShapeEnum({required this.label, required this.asset});

  final String label;
  final String asset;
}
