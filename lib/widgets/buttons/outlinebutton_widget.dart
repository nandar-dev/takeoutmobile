import 'package:flutter/material.dart';
import 'package:takeout/utils/font_sizes.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  final Color textColor;
  final Color iconColor;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final OutlinedBorder shape;
  final TextStyle? textStyle;
  final double fontSize;
  final double borderRadius;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
    this.borderColor = Colors.black,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
    this.shape = const RoundedRectangleBorder(),
    this.textStyle,
    this.fontSize = FontSizes.body,
    this.borderRadius = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    final style = OutlinedButton.styleFrom(
      shape: shape is RoundedRectangleBorder ? effectiveShape : shape,
      side: BorderSide(color: borderColor),
      padding: padding,
      overlayColor: borderColor.withValues(alpha: .1),
    );

    final label = Text(
      text,
      style: textStyle ??
          TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
    );

    if (icon != null) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor),
        label: label,
        style: style,
      );
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: style,
      child: label,
    );
  }
}