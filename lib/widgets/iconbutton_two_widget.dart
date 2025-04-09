import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takeout/theme/app_colors.dart';

class IconButtonTwoWidget extends StatelessWidget {
  final String icon;
  final Color? bgColor;
  final Color? iconColor;
  final VoidCallback onTap;
  final bool? active;
  final Color? activeColor;

  const IconButtonTwoWidget({
    super.key,
    required this.icon,
    required this.onTap,
    this.bgColor,
    this.iconColor,
    this.active = false,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color finalIconColor = active != null && active == true
        ? (activeColor ?? AppColors.primary)
        : (iconColor ?? AppColors.primary);

    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          icon,
          height: 12,
          width: 12,
          colorFilter: ColorFilter.mode(finalIconColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}
