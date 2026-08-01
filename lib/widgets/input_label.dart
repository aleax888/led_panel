import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  final String label;
  const InputLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF555555),
        fontSize: 10,
        letterSpacing: 2,
        fontFamily: 'Courier',
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
