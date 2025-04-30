import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/custom_text_button.dart';
import 'package:takeout/widgets/render_svg_icon.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    final walletIconSvg = "assets/icons/wallet_icon.svg";
    final title = "merchant_home.title".tr();
    final des = "merchant_home.description".tr();
    final withdraw = "merchant_home.withdraw".tr();

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: AppColors.primaryDark.withValues(alpha: .5),),
      ),

      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RenderSvgIcon(
                  assetName: walletIconSvg,
                  color: AppColors.primaryDark,
                ),
                SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TitleText(text: title, fontSize: FontSizes.heading3),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TitleText(text: "\$0.00"),
                SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: SubText(text: "profile.available".tr()),
                ),
              ],
            ),
            SizedBox(height: 8),
            SubText(
              text: des,
              color: AppColors.neutral70,
              fontSize: FontSizes.body,
            ),
            SizedBox(height: 12),
            CustomTextButton(
              btnLabel: withdraw,
              onTapCallback: ()=> Navigator.pushNamed(context, AppRoutes.merchantWithdrawlHistory),
              textColor: Colors.blueAccent,
              iconColor: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
