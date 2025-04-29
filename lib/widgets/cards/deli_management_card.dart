import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/render_svg_icon.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class DeliManagementCard extends StatelessWidget {
  const DeliManagementCard({super.key});

  @override
  Widget build(BuildContext context) {
    final truckIcon = "assets/icons/truck_icon.svg";
    final usersIcon = "assets/icons/users.svg";
    final hightlightColor = Color(0xff4F45E4);
    final bgColor = Color(0xffEEF2FF);

    final title = "merchant_home.deli_title".tr();
    final driverTitle = "merchant_home.driver_title".tr();
    final driverDes = "merchant_home.driver_des".tr();
    final btnLabel = "button.register_driver".tr();

    return Card(
      elevation: 1,
      color: AppColors.neutral10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: AppColors.neutral30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                RenderSvgIcon(assetName: truckIcon, color: hightlightColor),
                SizedBox(width: 12),
                TitleText(text: title, fontSize: FontSizes.heading3),
              ],
            ),
            SizedBox(height: 15),
            Card(
              elevation: 0,
              color: bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(color: hightlightColor.withValues(alpha: .1)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        backgroundColor: hightlightColor.withValues(alpha: .1),
                        child: RenderSvgIcon(
                          assetName: usersIcon,
                          color: hightlightColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      // Add Expanded here to allow text to take remaining space
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(
                            text: driverTitle,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                          SizedBox(height: 8,),
                          SubText(
                            text: driverDes,
                            color: AppColors.neutral80,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 12,),
                          CustomPrimaryButton(
                            text: btnLabel,
                            onPressed: () {},
                            backgroundColor: hightlightColor,
                            borderRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
