import 'package:flutter/material.dart';
import 'package:led_panel/theme/constants/app_durations.dart';

/// Displays an animated button for locking or unlocking the display.
class LockDisplayButton extends StatelessWidget {
  final bool isLocked;
  final VoidCallback onPressed;

  const LockDisplayButton({
    super.key,
    required this.isLocked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: isLocked ? 'Lock' : 'Unlock',
      icon: AnimatedSwitcher(
        duration: AppDurations.slow,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: Icon(
          isLocked ? Icons.lock_rounded : Icons.lock_open_rounded,
          key: ValueKey<bool>(isLocked),
        ),
      ),
    );
  }
}
