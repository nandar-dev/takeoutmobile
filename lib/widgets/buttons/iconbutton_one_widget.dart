import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takeout/theme/app_colors.dart';

class IconButtonOneWidget extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  final Color? borderColor;
  final Color? iconColor;
  final double? iconSize;
  final double? buttonSize;

  const IconButtonOneWidget({
    super.key,
    required this.icon,
    required this.onTap,
    this.borderColor,
    this.iconColor,
    this.iconSize,
    this.buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    final double actualButtonSize = buttonSize ?? 40.0;
    final double actualIconSize = iconSize ?? 24.0;

    return Container(
      height: actualButtonSize,
      width: actualButtonSize,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? AppColors.textLight,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          icon,
          height: actualIconSize,
          width: actualIconSize,
          colorFilter: ColorFilter.mode(
            iconColor ?? AppColors.textLight,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
