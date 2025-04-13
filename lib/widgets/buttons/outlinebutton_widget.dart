import 'package:flutter/material.dart';
import 'package:takeout/utils/font_sizes.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  final Color? textColor;
  final Color? iconColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;
  final TextStyle? textStyle;
  final double? fontSize;
  final double borderRadius;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.textColor,
    this.iconColor,
    this.borderColor,
    this.padding,
    this.shape,
    this.textStyle,
    this.fontSize,
    this.borderRadius = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveShape =
        shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        );

    final style = OutlinedButton.styleFrom(
      overlayColor: borderColor?.withValues(alpha: .1),
      shape: effectiveShape,
      side: BorderSide(color: borderColor ?? Colors.black),
      padding: padding ?? const EdgeInsets.symmetric(vertical: 14),
    );

    final label = Text(
      text,
      style:
          textStyle ??
          TextStyle(
            color: textColor ?? Colors.black,
            fontSize: fontSize ?? FontSizes.body,
            fontWeight: FontWeight.w500,
          ),
    );

    return icon != null
        ? OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: iconColor ?? Colors.black),
          label: label,
          style: style,
        )
        : OutlinedButton(onPressed: onPressed, style: style, child: label);
  }
}
