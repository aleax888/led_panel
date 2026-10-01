import 'package:flutter/material.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final int alpha;
  final String? toolTip;
  final double? fixedSize;
  final void Function()? onPressed;
  const AppIconButton({
    super.key,
    required this.icon,
    this.alpha = 100,
    this.toolTip,
    this.fixedSize,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface.withAlpha(alpha),
        shape: .circle,
      ),
      child: IconButton(
        tooltip: toolTip,
        onPressed: onPressed,
        icon: Icon(icon, color: context.colors.onSurface,),
        style: IconButton.styleFrom(
          fixedSize: fixedSize == null ? null : Size.square(fixedSize!),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
