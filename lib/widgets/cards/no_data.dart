import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    required this.noData,
    required this.noDataDes,
  });

  final String noData;
  final String noDataDes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral20,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month_outlined, color: AppColors.neutral50),
              SizedBox(height: 12),
              SubText(text: noData),
              SizedBox(height: 8),
              SubText(
                text: noDataDes,
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
