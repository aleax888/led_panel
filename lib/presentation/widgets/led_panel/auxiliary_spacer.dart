import 'package:flutter/material.dart';
import 'package:led_panel/extensions/context_extension.dart';

class AuxiliarySpacer extends StatelessWidget {
  final double? space;
  const AuxiliarySpacer({super.key, this.space});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: space ?? context.screenSize.width);
  }
}
