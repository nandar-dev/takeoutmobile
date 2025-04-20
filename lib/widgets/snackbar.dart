import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';

class Snackbar {
  static void showSuccess(BuildContext context, String message) {
    _showOverlaySnackbar(
      context,
      message,
      backgroundColor: AppColors.success,
    );
  }

  static void showError(BuildContext context, String message) {
    _showOverlaySnackbar(
      context,
      message,
      backgroundColor: AppColors.danger,
    );
  }

  static void _showOverlaySnackbar(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    Duration duration = const Duration(seconds: 1),
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 16,
        right: 16,
        child: Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: const TextStyle(color: AppColors.textLight, fontSize: 14),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}