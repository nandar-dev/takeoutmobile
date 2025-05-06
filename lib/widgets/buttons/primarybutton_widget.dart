import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/render_svg_icon.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final String? svgAssetPath;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double? fontSize;
  final bool disabled;
  final double iconSize;
  final bool iconAtEnd;
  final double iconSpacing;

  const CustomPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.svgAssetPath,
    this.height = 52.0,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.textStyle,
    this.padding,
    this.borderRadius = 24.0,
    this.fontSize,
    this.disabled = false,
    this.iconSize = 20,
    this.iconAtEnd = false,
    this.iconSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveFontSize = fontSize ?? FontSizes.body;
    final effectiveTextColor =
        disabled ? AppColors.neutral70 : textColor ?? AppColors.neutral10;
    final effectiveIconColor =
        disabled ? AppColors.neutral70 : iconColor ?? AppColors.neutral10;

    Widget? leadingIcon;
    if (svgAssetPath != null) {
      leadingIcon = RenderSvgIcon(
        assetName: svgAssetPath!,
        size: iconSize,
        color: effectiveIconColor,
      );
    } else if (icon != null) {
      leadingIcon = Icon(icon, color: effectiveIconColor, size: iconSize);
    }

    final textWidget = Text(
      text,
      style: textStyle ??
          TextStyle(
            color: effectiveTextColor,
            fontSize: effectiveFontSize,
            fontWeight: FontWeight.w600,
          ),
    );

    final btnChild = leadingIcon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: iconAtEnd
                ? [textWidget, SizedBox(width: iconSpacing), leadingIcon]
                : [leadingIcon, SizedBox(width: iconSpacing), textWidget],
          )
        : textWidget;

    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled
              ? AppColors.neutral10
              : backgroundColor ?? AppColors.primary,
          overlayColor: AppColors.neutral70.withValues(alpha: .1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
          elevation: 0,
        ),
        child: Opacity(opacity: disabled ? 0.8 : 1.0, child: btnChild),
      ),
    );
  }
}
