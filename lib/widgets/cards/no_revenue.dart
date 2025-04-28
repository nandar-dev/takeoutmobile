import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class NoRevenue extends StatelessWidget {
  const NoRevenue({
    super.key,
    required this.noRevenue,
    required this.noRevenueDes,
  });

  final String noRevenue;
  final String noRevenueDes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral20,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month_outlined, color: AppColors.neutral50),
              SizedBox(height: 12),
              SubText(text: noRevenue),
              SizedBox(height: 8),
              SubText(
                text: noRevenueDes,
                fontSize: FontSizes.sm,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
