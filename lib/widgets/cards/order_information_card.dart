import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class OrderInformationCard extends StatelessWidget {
  final String orderCount;
  final String label;
  final Color? bgColor;
  final Color? mainColor;
  final Color? secColor;

  const OrderInformationCard({
    super.key,
    required this.orderCount,
    required this.label,
    this.bgColor,
    this.mainColor,
    this.secColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        elevation: 0,
        color: bgColor ?? AppColors.neutral20,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleText(
                text: orderCount,
                color: mainColor ?? AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              TitleText(
                text: label,
                fontSize: FontSizes.heading2,
                color: secColor ?? AppColors.neutral80,
                maxLines: 2,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}