import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/custom_text_button.dart';
import 'package:takeout/widgets/formfields/custom_toggle_switch.dart';
import 'package:takeout/widgets/render_custom_image.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.paymentName,
    required this.accountName,
    required this.accountNumber,
    required this.imageUrl,
    required this.paymentId,
    this.onTap,
    this.isActive = true,
    this.onToggleChanged,
    this.onEdit,
  });

  final String paymentName;
  final String accountName;
  final String accountNumber;
  final String imageUrl;
  final int paymentId;
  final VoidCallback? onTap;
  final bool isActive;
  final ValueChanged<bool>? onToggleChanged;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.neutral20,
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neutral30, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Method Image
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: RenderCustomImage(
                imageUrl: imageUrl,
                height: 80,
                width: 80,
              ),
            ),
            const SizedBox(width: 16),

            // Payment info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubText(
                    text: paymentName,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSizes.heading3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  SubText(
                    text: accountName,
                    color: AppColors.neutral60,
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  SubText(
                    text: accountNumber,
                    color: AppColors.neutral60,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSizes.md,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Toggle & Edit section
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomToggleSwitch(
                  value: isActive,
                  onChanged: (val) => onToggleChanged?.call(val),
                ),
                SizedBox(height: 24),
                CustomTextButton(
                  btnLabel: "button.edit".tr(),
                  onTapCallback: () {},
                  textColor: AppColors.neutral70,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}