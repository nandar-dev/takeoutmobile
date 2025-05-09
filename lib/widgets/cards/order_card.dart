import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/data/models/test_order_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/custom_badge.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/expanded_section.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final totalStr = "cart.total".tr();
    final btnLabel1 = "cart.order_detail".tr();

    final DateTime createdAt = DateTime.parse(order.createdAt);
    final List items = order.orderItems;
    final totalItems = items.length;

    final total = items.fold<double>(
      0,
      (sum, item) => sum + (item['price'] as num).toDouble(),
    );

    return Card(
      elevation: 0.5,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.neutral30,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (with wrapped order number and status badge)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Flexible column to wrap long text
                Expanded(
                  child: Text(
                    "Order Number ${order.orderNo}",
                    softWrap: true,
                    maxLines: 2,
                    style: TextStyle(
                      color: AppColors.neutral80,
                      fontSize: FontSizes.body
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CustomBadge(
                  label: "status.${order.status}".tr(),
                  color: _statusColor(order.status),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Date and Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubText(
                  text: DateFormat.yMMMd().add_jm().format(createdAt),
                  color: AppColors.neutral80,
                  fontSize: FontSizes.sm,
                ),
                Row(
                  children: [
                    SubText(text: "$totalStr: \$ ", color: AppColors.neutral80),
                    SubText(
                      text: total.toString(),
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w900,
                    ),
                  ],
                ),
              ],
            ),
            const Divider(color: AppColors.neutral40),
            const SizedBox(height: 8),

            // Summary
            if (items.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SubText(
                          text: items.first['name'] ?? 'Unnamed Item',
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        SubText(
                          text:
                              "${items.first['price']} x ${items.first['quantity'] ?? 1}",
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  SubText(
                    text: "$totalItems item${totalItems > 1 ? 's' : ''}",
                    fontSize: FontSizes.sm,
                    color: AppColors.neutral80,
                  ),
                ],
              ),

            const SizedBox(height: 8),

            // Order Detail button
            SizedBox(
              height: 40,
              width: double.infinity,
              child: CustomPrimaryButton(
                borderRadius: 8,
                text: btnLabel1,
                onPressed:
                    () => Navigator.pushNamed(
                      context,
                      AppRoutes.orderDetail,
                      arguments: {'orderId': order.id},
                    ),
                backgroundColor: AppColors.neutral20,
                textColor: AppColors.neutral60,
              ),
            ),

            const SizedBox(height: 8),

            // Order Items collapsible list
            OrderItemList(orderItems: items),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "confirmed":
        return AppColors.primaryDark;
      case "completed":
        return Colors.blueAccent;
      case "pending":
        return AppColors.yello500;
      case "shipped":
        return Colors.purpleAccent;
      case "rejected":
        return Colors.red;
      case "cancelled":
        return Colors.red;
      default:
        return AppColors.neutral60;
    }
  }
}

// collapse order items list
class OrderItemList extends StatefulWidget {
  final List<dynamic> orderItems;

  const OrderItemList({super.key, required this.orderItems});

  @override
  State<OrderItemList> createState() => _OrderItemListState();
}

class _OrderItemListState extends State<OrderItemList> {
  bool _showItems = false;

  void _toggleItems() {
    setState(() {
      _showItems = !_showItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalStr = "cart.total".tr();
    final orderItems = "cart.order_items".tr();
    final total = widget.orderItems.fold<double>(
      0,
      (sum, item) => sum + (item['price'] as num).toDouble(),
    );

    return Column(
      children: [
        // Toggle button
        SizedBox(
          height: 40,
          width: double.infinity,
          child: CustomPrimaryButton(
            borderRadius: 8,
            text: orderItems,
            onPressed: _toggleItems,
            backgroundColor: AppColors.neutral10,
            textColor: AppColors.neutral60,
            icon:
                _showItems
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
            iconColor: AppColors.neutral60,
            iconAtEnd: true,
          ),
        ),
        const SizedBox(height: 8),
        // Collapsible content
        ExpandedSection(
          expand: _showItems,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Divider(color: AppColors.neutral40),
                const SizedBox(height: 8),
                ...widget.orderItems.map<Widget>((item) {
                  final name = item['name'] ?? 'Unnamed';
                  final quantity = item['quantity'] ?? 1;
                  final price = (item['price'] as num).toDouble();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildOrderItem(
                      name: name,
                      quantity: quantity,
                      price: price,
                    ),
                  );
                }),
                Divider(color: AppColors.neutral40),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubText(text: totalStr),
                    SubText(
                      text: total.toStringAsFixed(2),
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryDark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItem({
    required String name,
    required int quantity,
    required double price,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubText(
                text: name,
                fontWeight: FontWeight.w500,
                color: AppColors.neutral90,
              ),
              SubText(
                text: "${price.toStringAsFixed(2)} x $quantity",
                fontSize: FontSizes.sm,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        SubText(
          text: (price * quantity).toStringAsFixed(2),
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}