import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class SortButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? label;
  final String? icon;
  final double? iconHeight;
  final double? iconWeight;
  final double? angleVal;

  const SortButton({
    super.key,
    required this.onTap,
    this.label,
    this.icon,
    this.iconHeight,
    this.iconWeight,
    this.angleVal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      splashColor: AppColors.neutral30,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neutral40),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: (label == null || icon == null)
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            if (label != null)
              SubText(
                text: label ?? "",
                color: AppColors.textPrimary,
                fontSize: FontSizes.body,
              ),
            if (label != null && icon != null)
              const SizedBox(width: 8),
            if (icon != null)
              Transform.rotate(
                angle: angleVal ?? 0,
                child: SvgPicture.asset(
                  icon ?? "assets/icons/chevron_right.svg",
                  height: iconHeight ?? 8,
                  width: iconWeight ?? 8,
                  colorFilter: const ColorFilter.mode(
                    AppColors.neutral70,
                    BlendMode.srcIn,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
