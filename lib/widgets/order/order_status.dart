import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/custom_badge.dart';
import 'package:takeout/widgets/buttons/iconbutton_two_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key, required this.status, required this.orderNo});

  final String status;
  final String orderNo;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      color: AppColors.background,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(color: _borderColorByStatus(status), width: 6),
            top: BorderSide(color: _borderColorByStatus(status), width: 1),
            right: BorderSide(color: _borderColorByStatus(status), width: 1),
            bottom: BorderSide(color: _borderColorByStatus(status), width: 1),
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButtonTwoWidget(
                  icon: _orderStatusIcon(status),
                  onTap: () {},
                  iconColor: _orderStatusColor(status),
                  bgColor: _orderStatusColor(status).withValues(alpha: .1),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TitleText(
                            text: "status.$status".tr(),
                            fontSize: FontSizes.heading3,
                            fontWeight: FontWeight.bold,
                            color: _orderStatusColor(status),
                          ),
                          CustomBadge(
                            label: orderNo,
                            color: AppColors.neutral80,
                            variant: BadgeVariant.outlined,
                            showBorder: false,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      SubText(
                        text: "order.${status}_des".tr(),
                        color: AppColors.neutral80,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (status == "pending") ...[
              const SizedBox(height: 8),
              const Divider(color: AppColors.neutral40),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: CustomPrimaryButton(
                  borderRadius: 8,
                  backgroundColor: AppColors.danger,
                  textColor: AppColors.textLight,
                  svgAssetPath: "assets/icons/stop_icon.svg",
                  iconColor: AppColors.textLight,
                  text: "button.cancel_order".tr(),
                  onPressed: () {},
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}



String _orderStatusIcon(String status){
  switch (status) {
    case "confirmed":
      return "assets/icons/check_circle1.svg";
    case "completed":
      return "assets/icons/check_circle1.svg";
    case "cancelled":
      return "assets/icons/close_circle.svg";
    default:
      return "assets/icons/detail_icon.svg";
  }
}

Color _borderColorByStatus(String status) {
  switch (status.toLowerCase()) {
    case "confirmed":
      return AppColors.primaryDark;
    case "rejected":
      return Colors.red;
    case "cancelled":
      return Colors.red;
    default:
      return AppColors.neutral40;
  }
}


Color _orderStatusColor(String status) {
  switch (status.toLowerCase()) {
    case "confirmed":
      return AppColors.primaryDark;
    case "completed":
      return Colors.indigoAccent;
    case "pending":
      return AppColors.yello500;
    case "shipped":
      return Colors.purpleAccent;
    case "rejected":
      return Colors.red;
    case "cancelled":
      return Colors.red;
    default:
      return AppColors.neutral40;
  }
}