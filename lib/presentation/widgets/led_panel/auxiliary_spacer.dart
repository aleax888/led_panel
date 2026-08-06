import 'package:flutter/material.dart';
import 'package:led_panel/extensions/context_extension.dart';

class AuxiliarySpacer extends StatelessWidget {
  const AuxiliarySpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: context.screenSize.width);
  }
}
