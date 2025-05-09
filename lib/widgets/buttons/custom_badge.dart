import 'package:flutter/material.dart';

enum BadgeVariant { outlined, contained }

class CustomBadge extends StatelessWidget {
  final String label;
  final Color color; // fallback base color
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final BadgeVariant variant;
  final EdgeInsets padding;
  final double fontSize;
  final bool showBorder;

  const CustomBadge({
    super.key,
    required this.label,
    required this.color,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.variant = BadgeVariant.contained,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    this.fontSize = 14,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOutlined = variant == BadgeVariant.outlined;
    final Color bgColor = backgroundColor ??
        (isOutlined ? color.withValues(alpha: .1) : color);
    final Color effectiveBorderColor = borderColor ?? color;
    final Color effectiveTextColor =
        textColor ?? (isOutlined ? color : Colors.white);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        border: showBorder ? Border.all(color: effectiveBorderColor) : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: effectiveTextColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}