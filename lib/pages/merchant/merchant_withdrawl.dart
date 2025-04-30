import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/cards/no_data.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class MerchantWithdrawl extends StatelessWidget {
  const MerchantWithdrawl({super.key});

  @override
  Widget build(BuildContext context) {
    final title = "merchant_home.withdraw".tr();
    final des = "withdrawl.description".tr();
    final noDataTitle = "withdrawl.no_data_title".tr();
    final noDataDes = "withdrawl.no_data_description".tr();

    return Scaffold(
      appBar: AppBarWidget(title: title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubText(text: des, fontSize: FontSizes.body),
            SizedBox(height: 24,),
            SizedBox(
              height: 200,
              child: NoData(icon: Icons.history_outlined, noData: noDataTitle, noDataDes: noDataDes, backgroundColor: Colors.transparent,),
            ),
          ],
        ),
      ),
    );
  }
}
