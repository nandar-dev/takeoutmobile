import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeout/data/models/test_order_model.dart';
import 'package:takeout/pages/user/order/items_and_timeline.dart';
import 'package:takeout/pages/user/order/order_informations.dart';
import 'package:takeout/pages/user/order/order_summary.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/order/deli_status.dart';
import 'package:takeout/widgets/order/order_status.dart';

class OrderDetail extends StatefulWidget {
  final int orderId;

  const OrderDetail({super.key, required this.orderId});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  OrderModel? _selectedOrder;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final orders = await loadOrdersFromJson();
    final selected = orders.firstWhere((order) => order.id == widget.orderId);
    setState(() {
      _selectedOrder = selected;
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
    if (_selectedOrder == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final title = "cart.order_detail".tr();
    final orderStatus = _selectedOrder!.status;
    final orderNo = _selectedOrder!.orderNo;
    final totalItems = _selectedOrder!.orderItems.length;
    final createdAt = _selectedOrder!.createdAt;
    final DateTime parsedDate = DateTime.parse(createdAt);
    final String formattedDate = DateFormat.yMMMMd().format(parsedDate);
    final String formattedTime = DateFormat.jm().format(parsedDate);

    return Scaffold(
      appBar: AppBarWidget(title: title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              OrderStatus(status: orderStatus, orderNo: orderNo),
              const SizedBox(height: 12),
              DeliveryStatus(selectedOrder: _selectedOrder!),
              const SizedBox(height: 12),
              // order info grid
              OrderInformations(
                date: formattedDate,
                time: formattedTime,
                totalItems: totalItems.toString(),
                voucherId: orderNo,
              ),
              //order summary
              OrderSummary(),
              const SizedBox(height: 12),
              ItemsAndTimeline(
                orderItems: _selectedOrder!.orderItems,
                date: formattedDate,
                time: formattedTime,
                deliStatus: _selectedOrder!.deliStatus,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
