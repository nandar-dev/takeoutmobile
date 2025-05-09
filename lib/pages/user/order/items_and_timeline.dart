import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/buttons/iconbutton_two_widget.dart';
import 'package:takeout/widgets/order/order_item.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ItemsAndTimeline extends StatelessWidget {
  const ItemsAndTimeline({
    super.key,
    required this.orderItems,
    required this.date,
    required this.time,
    required this.deliStatus,
  });

  final List<dynamic> orderItems;
  final String date;
  final String time;
  final int deliStatus;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            dividerColor: AppColors.neutral30,
            labelColor: AppColors.primaryDark,
            unselectedLabelColor: AppColors.neutral70,
            indicatorColor: AppColors.primary,
            splashFactory: InkSplash.splashFactory,
            splashBorderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            tabs: const [Tab(text: 'Order Items'), Tab(text: 'Order Timeline')],
          ),
          const SizedBox(height: 16),
          _TabSwitcher(
            orderItems: orderItems,
            date: date,
            time: time,
            deliStatus: deliStatus,
          ),
        ],
      ),
    );
  }
}

class _TabSwitcher extends StatelessWidget {
  const _TabSwitcher({
    required this.orderItems,
    required this.date,
    required this.time,
    required this.deliStatus,
  });

  final List<dynamic> orderItems;
  final String date;
  final String time;
  final int deliStatus;

  @override
  Widget build(BuildContext context) {
    final tabController = DefaultTabController.of(context);

    return AnimatedBuilder(
      animation: tabController,
      builder: (context, _) {
        if (tabController.index == 0) {
          return _buildOrderItems();
        } else {
          return _buildOrderTimeline();
        }
      },
    );
  }

  Widget _buildOrderItems() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orderItems.length,
      itemBuilder: (context, index) {
        final item = orderItems[index];
        final quantity = item["quantity"] ?? 0;
        final price = item["price"] ?? 0.0;
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: OrderItem(
            item: item,
            quantity: quantity,
            price: price,
            deliStatus: deliStatus,
            backgroundColor: AppColors.background,
          ),
        );
      },
    );
  }

  Widget _buildOrderTimeline() {
    final steps = [
      {
        "title": "order.title_1".tr(),
        "subtitle": "$date at $time",
        "description": "order.des_1".tr()
      },
      {
        "title": "order.title_2".tr(),
        "subtitle": "status.pending".tr(),
        "description": "order.des_2".tr()
      },
      {
        "title": "order.title_3".tr(),
        "subtitle": null,
        "description": "order.des_3".tr()
      },
      {
        "title": "order.title_4".tr(),
        "subtitle": null,
        "description": "order.des_4".tr()
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neutral30, width: 1),
      ),
      child: Column(
        children:
            steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isLast = index == steps.length - 1;
              final isCompleted = index < deliStatus;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      IconButtonTwoWidget(
                      icon: isCompleted ? "assets/icons/check_circle1.svg" : "assets/icons/close_circle.svg",
                        onTap: () {},
                        iconSize: 18,
                        bgColor:
                            isCompleted
                                ? AppColors.success.withValues(alpha: .1)
                                : AppColors.danger.withValues(alpha: .1),
                        iconColor:
                            isCompleted
                                ? AppColors.success
                                : AppColors.danger,
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 40,
                          color: AppColors.neutral30,
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(
                            text: step['title'] ?? '',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                          if (step['subtitle'] != null)
                            SubText(
                              text: step['subtitle']!,
                              color: AppColors.neutral60,
                            ),
                          if (step['description'] != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: SubText(
                                text: step['description']!,
                                color: AppColors.neutral70,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}
