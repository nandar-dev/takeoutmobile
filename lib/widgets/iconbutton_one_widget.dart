import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takeout/theme/app_colors.dart';

class IconButtonOneWidget extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;

  const IconButtonOneWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.textLight,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          icon,
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}
