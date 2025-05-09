import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/iconbutton_two_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class CancelledStatus extends StatelessWidget {
  const CancelledStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.neutral20.withValues(alpha: .7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.neutral30, width: 1),
        ),
        child: Row(
          children: [
            IconButtonTwoWidget(
              icon: "assets/icons/stop_icon.svg",
              onTap: () {},
              iconColor: AppColors.neutral60,
              bgColor: AppColors.neutral50.withValues(alpha: .2),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubText(
                    text: "order.no_deli_title".tr(),
                    color: AppColors.textPrimary,
                    fontSize: 17,
                  ),
                  const SizedBox(height: 4),
                  SubText(
                    text: "order.no_deli_des".tr(),
                    color: AppColors.neutral70,
                    fontSize: FontSizes.body,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}