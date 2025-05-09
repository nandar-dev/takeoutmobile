import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/widgets/cards/order_info_card.dart';

class OrderInformations extends StatelessWidget {
  const OrderInformations({
    super.key,
    required this.date,
    required this.time,
    required this.totalItems,
    required this.voucherId,
  });

  final String date;
  final String time;
  final String totalItems;
  final String voucherId;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 2.9,
      children: [
        OrderInfo(
          iconPath: "assets/icons/calendar.svg",
          label: "order.date".tr(),
          data: date,
        ),
        OrderInfo(
          iconPath: "assets/icons/clock.svg",
          label: "order.time".tr(),
          data: time,
        ),
        OrderInfo(
          iconPath: "assets/icons/cube.svg",
          label: "order.items".tr(),
          data: "$totalItems ${int.parse(totalItems) > 1 ? "order.item".tr() : "order.items".tr()}",
        ),
        OrderInfo(
          iconPath: "assets/icons/pack_icon.svg",
          label: "order.voucher".tr(),
          data: voucherId,
        ),
      ],
    );
  }
}
