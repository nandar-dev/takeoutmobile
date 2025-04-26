import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double? fontSize;
  final bool? disabled;

  const CustomPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.icon,
    this.height = 52.0,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.textStyle,
    this.padding,
    this.borderRadius = 24.0,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveFontSize = fontSize ?? FontSizes.body;

    // Decide on the text and icon color when the button is disabled
    final effectiveTextColor =
        disabled == true
            ? AppColors
                .neutral70 // Darker text color when disabled
            : textColor ?? AppColors.neutral10;

    final effectiveIconColor =
        disabled == true
            ? AppColors
                .neutral70 // Darker icon color when disabled
            : iconColor ?? AppColors.neutral10;

    final btnChild =
        icon == null
            ? Text(
              text,
              style:
                  textStyle ??
                  TextStyle(
                    color: effectiveTextColor,
                    fontSize: effectiveFontSize,
                    fontWeight: FontWeight.w600,
                  ),
            )
            : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: effectiveIconColor),
                const SizedBox(width: 8),
                Text(
                  text,
                  style:
                      textStyle ??
                      TextStyle(
                        color: effectiveTextColor,
                        fontSize: effectiveFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            );

    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: disabled == true ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor:
              disabled == true
                  ? AppColors.neutral10
                  : backgroundColor ?? AppColors.primary,
          overlayColor: AppColors.neutral70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: disabled == true ? 0 : 2,
        ),
        child: Opacity(opacity: disabled == true ? 0.8 : 1.0, child: btnChild),
      ),
    );
  }
}
