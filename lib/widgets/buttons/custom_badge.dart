import 'package:flutter/material.dart';

enum BadgeVariant { outlined, contained }

class CustomBadge extends StatelessWidget {
  final String label;
  final Color color;
  final BadgeVariant variant;
  final EdgeInsets padding;
  final double fontSize;

  const CustomBadge({
    super.key,
    required this.label,
    required this.color,
    this.variant = BadgeVariant.contained,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOutlined = variant == BadgeVariant.outlined;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: isOutlined ? color.withValues(alpha: .1) : color,
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isOutlined ? color : Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
