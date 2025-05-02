import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/cards/payment_card.dart';
import 'package:takeout/widgets/formfields/custom_radio_input.dart';
import 'package:takeout/widgets/formfields/customdropdownfield_widget.dart';
import 'package:takeout/widgets/formfields/customtextfield_widget.dart';

class MerchantPayment extends StatefulWidget {
  const MerchantPayment({super.key});

  @override
  State<MerchantPayment> createState() => _MerchantPaymentState();
}

class _MerchantPaymentState extends State<MerchantPayment> {
  String? selectedPaymentMethod;
  String? selectedStatus;
  final List<String> paymentMethodOptions = [
    "KBZ",
    "AYA",
    "Wave Pay",
    "CB",
    "K Pay",
    "CB Pay",
    "AYA Pay",
  ];
  final List<String> statusOptions = ["active", "inactive"];

  @override
  Widget build(BuildContext context) {
    final title = "title.merchant_payment".tr();
    final label1 = "merchant_payment.label1".tr();
    final placeholder1 = "merchant_payment.placeholder1".tr();
    final label2 = "merchant_payment.label2".tr();
    final placeholder2 = "merchant_payment.placeholder2".tr();
    final label3 = "merchant_payment.label3".tr();
    final placeholder3 = "merchant_payment.placeholder3".tr();

    return Scaffold(
      appBar: AppBarWidget(
        title: title,
        onBackTap: () => Navigator.pushNamed(context, AppRoutes.appNavigation),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Form inputs (not scrollable)
            CustomDropdownFormField<String>(
              label: label1,
              value: selectedPaymentMethod,
              items: paymentMethodOptions,
              hintText: placeholder1,
              onChanged: (val) {
                setState(() {
                  selectedPaymentMethod = val;
                });
              },
              validator: (val) => val == null ? placeholder1 : null,
            ),
            const SizedBox(height: 12),

            CustomTextField(label: label2, hint: placeholder2),
            const SizedBox(height: 12),

            CustomTextField(label: label3, hint: placeholder3),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: CustomRadioInput<String>(
                    label: "status.active".tr(),
                    value: statusOptions[0],
                    groupValue: selectedStatus,
                    onChanged:
                        (value) => setState(() => selectedStatus = value),
                    activeColor: Colors.green,
                    showBorder: true,
                    dense: true,
                  ),
                ),
                Expanded(
                  child: CustomRadioInput<String>(
                    label: "status.inactive".tr(),
                    value: statusOptions[1],
                    groupValue: selectedStatus,
                    onChanged:
                        (value) => setState(() => selectedStatus = value),
                    activeColor: Colors.red,
                    showBorder: true,
                    dense: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 45,
              child: CustomPrimaryButton(
                borderRadius: 8,
                text: "button.confirm".tr(),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 24),

            // Scrollable payment list (only this section scrolls)
            Expanded(
              child: ListView.separated(
                itemCount: dummyPayments.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
  final payment = dummyPayments[index];
  return PaymentCard(
    paymentName: payment['paymentName'],
    accountName: payment['accountName'],
    accountNumber: payment['accountNumber'],
    imageUrl: payment['imageUrl'],
    paymentId: payment['paymentId'],
    isActive: payment['isActive'] ?? true, // Add isActive field to your data
    onToggleChanged: (value) {
      setState(() {
        dummyPayments[index]['isActive'] = value;
      });
    },
    onEdit: () {
      // Handle edit logic here
      print("Edit payment ID: ${payment['paymentId']}");
    },
    onTap: () {},
  );
}

              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> dummyPayments = [
  {
    "paymentName": "KBZ Pay",
    "accountName": "John Doe",
    "accountNumber": "09*********",
    "imageUrl": "https://play-lh.googleusercontent.com/cnKJYzzHFAE5ZRepCsGVhv7ZnoDfK8Wu5z6lMefeT-45fTNfUblK_gF3JyW5VZsjFc4=w240-h480-rw",
    "paymentId": 1,
    "isActive": true,
  },
  {
    "paymentName": "AYA Pay",
    "accountName": "Jane Smith",
    "accountNumber": "09********1",
    "imageUrl": "https://ayapay.com/wp-content/uploads/2024/09/ayapay-feature.jpg",
    "paymentId": 2,
    "isActive": false,
  },
  {
    "paymentName": "Wave Pay",
    "accountName": "Mya Aye",
    "accountNumber": "09********2",
    "imageUrl": "https://cdn6.aptoide.com/imgs/a/d/0/ad05b74cd5f80b55498d98a21368e43e_fgraphic.png",
    "paymentId": 3,
    "isActive": true,
  },
];
