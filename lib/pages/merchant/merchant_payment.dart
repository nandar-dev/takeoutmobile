import 'package:flutter/material.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class MerchantPayment extends StatelessWidget {
  const MerchantPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SubText(text: "merchant payment"),
      ),
    );
  }
}