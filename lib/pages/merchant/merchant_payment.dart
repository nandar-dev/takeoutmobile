import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/widgets/appbar_widget.dart';

class MerchantPayment extends StatelessWidget {
  const MerchantPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final title = "title.merchant_payment".tr();
    return Scaffold(
      appBar: AppBarWidget(title: title, showBackNavigator: false,),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
