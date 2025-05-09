import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeout/data/models/test_order_model.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/cards/no_data.dart';
import 'package:takeout/widgets/cards/order_card.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  final noDataTitle = "message.no_order_title".tr();
  final noDataDes = "message.no_order_des".tr();
  List<OrderModel> _orders = [];
  final List<String> statusList = [
    "all",
    "pending",
    "confirmed",
    "shipped",
    "completed",
    "cancelled",
    "rejected",
  ];

  String selectedStatus = "all";

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final orders = await loadOrdersFromJson();
    setState(() {
      _orders = orders;
    });
  }

  Future<List<OrderModel>> loadOrdersFromJson() async {
    final String response = await rootBundle.loadString(
      'assets/data/orders.json',
    );
    final data = json.decode(response) as List;
    return data.map((e) => OrderModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final title = "title.my_orders".tr();

    return Scaffold(
      appBar: AppBarWidget(title: title),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Filter Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children:
                    statusList.map((status) {
                      final isSelected = status == selectedStatus;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomPrimaryButton(
                          text: "status.$status".tr(),
                          onPressed: () {
                            setState(() {
                              selectedStatus = status;
                            });
                          },
                          backgroundColor:
                              isSelected
                                  ? AppColors.primary
                                  : AppColors.neutral80,
                          textColor: AppColors.textLight,
                          borderRadius: 24,
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Orders List or No Data
            _orders.isEmpty
                ? NoData(
                  noData: noDataTitle,
                  noDataDes: noDataDes,
                  icon: "assets/icons/order_icon.svg",
                )
                : Expanded(
                  child: ListView.separated(
                    itemCount: _orders.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      return OrderCard(order: _orders[index]);
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
