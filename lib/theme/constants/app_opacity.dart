/// Valores de opacidad (alpha) reutilizables en toda la app.
///
/// Se usan junto a `Color.withValues(alpha: ...)` para evitar
/// valores mágicos de transparencia dispersos en los widgets.
class AppOpacity {
  AppOpacity._();

  static const int disabled = 100;
  static const int subtle = 20;
  static const int glow = 150;
}
