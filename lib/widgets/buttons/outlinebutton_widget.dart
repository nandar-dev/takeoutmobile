import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takeout/utils/font_sizes.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  final String? svgAssetPath;
  final Color textColor;
  final Color iconColor;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final OutlinedBorder shape;
  final TextStyle? textStyle;
  final double fontSize;
  final double borderRadius;
  final double iconSize;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.svgAssetPath,
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
    this.borderColor = Colors.black,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
    this.shape = const RoundedRectangleBorder(),
    this.textStyle,
    this.fontSize = FontSizes.body,
    this.borderRadius = 24.0,
    this.iconSize = 20,
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

    Widget? leadingIcon;

    if (svgAssetPath != null) {
      leadingIcon = SvgPicture.asset(
        svgAssetPath!,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        height: iconSize,
        width: iconSize,
      );
    } else if (icon != null) {
      leadingIcon = Icon(icon, color: iconColor, size: iconSize);
    }

    if (leadingIcon != null) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: leadingIcon,
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
