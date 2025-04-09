import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.height = 52.0,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final btnChild =
        icon == null
            ? Text(
              text,
              style:
                  textStyle ??
                  TextStyle(
                    color: textColor ?? AppColors.neutral10,
                    fontSize: FontSizes.body,
                    fontWeight: FontWeight.w600,
                  ),
            )
            : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor ?? AppColors.neutral10),
                const SizedBox(width: 8),
                Text(
                  text,
                  style:
                      textStyle ??
                      TextStyle(
                        color: textColor ?? AppColors.neutral10,
                        fontSize: FontSizes.body,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            );

    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: backgroundColor ?? AppColors.primary,
          overlayColor: AppColors.neutral30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: btnChild,
      ),
    );
  }
}
