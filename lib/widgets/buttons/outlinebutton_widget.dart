import 'package:flutter/material.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    final style = OutlinedButton.styleFrom(
      overlayColor: borderColor,
      shape: shape ?? const StadiumBorder(),
      side: BorderSide(color: borderColor ?? Colors.black),
      padding: padding ?? const EdgeInsets.symmetric(vertical: 14),
    );

    final label = Text(
      text,
      style:
          textStyle ??
          TextStyle(
            color: textColor ?? Colors.black,
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
