import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:led_panel/theme/constants/app_colors.dart';
import 'package:led_panel/theme/constants/app_radius.dart';
import 'package:led_panel/theme/constants/app_spacing.dart';
import 'package:led_panel/utils/extensions/context_extension.dart';
import 'package:led_panel/utils/global_context.dart';

class ToastHandler {
  ToastHandler._();

  static FToast? _fToast;

  static FToast _getFToast() {
    final context = GlobalContext.globalContext;

    if (context == null) {
      throw StateError('The global navigator context is not available.');
    }

    return _fToast ??= FToast()..init(context);
  }

  static void showSuccess(String message) {
    _show(
      message: message,
      color: AppColors.success,
      icon: Icons.check_circle,
      foregroundColor: AppColors.white,
    );
  }

  static void showWarning(String message) {
    _show(
      message: message,
      color: AppColors.warning,
      icon: Icons.warning,
      foregroundColor: AppColors.black,
    );
  }

  static void showError(String message) {
    _show(
      message: message,
      color: AppColors.error,
      icon: Icons.error,
      foregroundColor: AppColors.white,
    );
  }

  static void showInfo(String message) {
    _show(
      message: message,
      color: AppColors.info,
      icon: Icons.info,
      foregroundColor: AppColors.white,
    );
  }

  static void _show({
    required String message,
    required Color color,
    required IconData icon,
    required Color foregroundColor,
  }) => _getFToast().showToast(
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppRadius.borderRadiusMd,
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          Icon(icon, color: foregroundColor),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              message,
              style: GlobalContext.globalContext?.textTheme.bodyMedium
                  ?.copyWith(color: foregroundColor),
            ),
          ),
        ],
      ),
    ),
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 3),
  );
}
