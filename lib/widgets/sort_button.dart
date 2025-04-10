import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class SortButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? label;
  final String? icon;

  const SortButton({
    super.key,
    required this.onTap,
    this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SubText(text: label ?? "", color: AppColors.textPrimary, fontSize: FontSizes.body,),
            const SizedBox(width: 8),
            SvgPicture.asset(
              icon ?? "assets/icons/chevron_right.svg",
              height: 8,
              width: 8,
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
