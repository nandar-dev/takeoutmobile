import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/render_svg_icon.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({
    super.key,
    required this.iconPath,
    required this.label,
    required this.data,
  });

  final String iconPath;
  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neutral40, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RenderSvgIcon(
            assetName: iconPath,
            color: AppColors.neutral70,
            size: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (label.isNotEmpty)
                  SubText(
                    text: label,
                    fontSize: FontSizes.body,
                    color: AppColors.neutral70,
                  ),
                SubText(
                  text: data,
                  color: AppColors.textPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

