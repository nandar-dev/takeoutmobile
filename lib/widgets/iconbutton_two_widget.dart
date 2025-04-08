import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takeout/theme/app_colors.dart';


class IconButtonTwoWidget extends StatelessWidget {
  final String icon;
  final Color? bgColor;
  final Color? iconColor;
  final VoidCallback onTap;

  const IconButtonTwoWidget({
    super.key,
    this.bgColor,
    this.iconColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.primary.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          icon,
          height: 12,
          width: 12,
          color: iconColor ?? AppColors.primary,
        ),
      ),
    );
  }
}
