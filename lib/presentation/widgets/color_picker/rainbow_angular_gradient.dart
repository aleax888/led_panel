import 'package:flutter/material.dart';

class RainbowAngularGradient extends StatelessWidget {
  final double width;
  final double height;
  const RainbowAngularGradient({
    super.key,
    this.width = 100.0,
    this.height = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          startAngle: 0,
          endAngle: 2 * 3.14159,
          colors: const [
            Color(0xFFFF0000), // Rojo
            Color(0xFFFF8000), // Naranja
            Color(0xFFFFFF00), // Amarillo
            Color(0xFF80FF00), // Verde claro
            Color(0xFF00FF00), // Verde
            Color(0xFF00FFFF), // Cian
            Color(0xFF0080FF), // Azul claro
            Color(0xFF0000FF), // Azul
            Color(0xFF8000FF), // Morado
            Color(0xFFFF00FF), // Magenta
            Color(0xFFFF0000), // Cierra el gradiente
          ],
        ),
      ),
    );
  }
}
