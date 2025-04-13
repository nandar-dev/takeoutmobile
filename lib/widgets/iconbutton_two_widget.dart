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
  final double? iconSize;
  final double? buttonSize;

  const IconButtonTwoWidget({
    super.key,
    required this.icon,
    required this.onTap,
    this.bgColor,
    this.iconColor,
    this.active = false,
    this.activeColor,
    this.iconSize,
    this.buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    final Color finalIconColor = active == true
        ? (activeColor ?? AppColors.primary)
        : (iconColor ?? AppColors.primary);
    final double actualButtonSize = buttonSize ?? 40.0;
    final double actualIconSize = iconSize ?? 24.0;

    return Container(
      height: actualButtonSize,
      width: actualButtonSize,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.primary.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          icon,
          height: actualIconSize,
          width: actualIconSize,
          colorFilter: ColorFilter.mode(finalIconColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:takeout/theme/app_colors.dart';

// class IconButtonWidget extends StatelessWidget {
//   final String icon;
//   final VoidCallback onTap;
//   final bool showBorder;
//   final bool isActive;
//   final Color? borderColor;
//   final Color? iconColor;
//   final Color? activeColor;
//   final Color? backgroundColor;
//   final double? iconSize;
//   final double? buttonSize;

//   const IconButtonWidget({
//     super.key,
//     required this.icon,
//     required this.onTap,
//     this.showBorder = false,
//     this.isActive = false,
//     this.borderColor,
//     this.iconColor,
//     this.activeColor,
//     this.backgroundColor,
//     this.iconSize,
//     this.buttonSize,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final double actualButtonSize = buttonSize ?? 40.0;
//     final double actualIconSize = iconSize ?? 24.0;

//     final Color finalIconColor =
//         isActive
//             ? (activeColor ?? AppColors.primary)
//             : (iconColor ?? AppColors.primary);

//     return Container(
//       height: actualButtonSize,
//       width: actualButtonSize,
//       decoration: BoxDecoration(
//         color: backgroundColor ?? Colors.transparent,
//         border:
//             showBorder
//                 ? Border.all(
//                   color: borderColor ?? AppColors.textLight,
//                   width: 1,
//                 )
//                 : null,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: IconButton(
//         onPressed: onTap,
//         icon: SvgPicture.asset(
//           icon,
//           height: actualIconSize,
//           width: actualIconSize,
//           colorFilter: ColorFilter.mode(finalIconColor, BlendMode.srcIn),
//         ),
//       ),
//     );
//   }
// }
