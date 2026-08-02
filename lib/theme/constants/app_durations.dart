/// Duraciones de animación y transición reutilizables en toda la app.
///
/// Evita valores mágicos de `Duration(milliseconds: ...)` dispersos
/// en los widgets.
class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 400);
}