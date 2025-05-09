import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neutral40, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(text: "order.summary".tr(), fontSize: FontSizes.heading3,),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubText(text: "Subtotal"),
              SubText(text: "19.00", color: AppColors.textPrimary,)
            ],
          ),
          SizedBox(height: 12,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubText(text: "Discount"),
              SubText(text: "-0.00", color: AppColors.success,)
            ],
          ),
          SizedBox(height: 12,),

          Divider(color: AppColors.neutral40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleText(text: "Total", fontSize: FontSizes.heading3,),
              SubText(text: "19.00", color: AppColors.primaryDark, fontWeight: FontWeight.w700,)
            ],
          ),
        ],
      ),
    );
  }
}