import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/data/models/test_order_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/custom_badge.dart';
import 'package:takeout/widgets/buttons/iconbutton_two_widget.dart';
import 'package:takeout/widgets/expanded_section.dart';
import 'package:takeout/widgets/order/cancel_status.dart';
import 'package:takeout/widgets/order/order_item.dart';
import 'package:takeout/widgets/render_svg_icon.dart';
import 'package:takeout/widgets/typography_widgets.dart';

final List<String> stepLabels = const [
  'status.preparing',
  'status.deli_prep',
  'status.onway',
  'status.delivered',
];

class DeliveryStatus extends StatefulWidget {
  const DeliveryStatus({super.key, required this.selectedOrder});

  final OrderModel selectedOrder;

  @override
  State<DeliveryStatus> createState() => _DeliveryStatusState();
}

class _DeliveryStatusState extends State<DeliveryStatus> {
  bool _isExpanded = false;

  Widget _buildDriverInfoRow(int totalItems, int deliStatus) {
    return Row(
      children: [
        IconButtonTwoWidget(
          icon: "assets/icons/user1.svg",
          onTap: () {},
          iconSize: 18,
          bgColor: Colors.indigoAccent.withValues(alpha: .15),
          iconColor: Colors.indigo,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubText(
                text: "Driver Name",
                color: AppColors.textPrimary,
              ),
              Row(
                children: [
                  SubText(
                    text: "$totalItems items",
                    color: AppColors.neutral60,
                    fontSize: FontSizes.body,
                  ),
                  if (deliStatus == 4) ...[
                    const SizedBox(width: 2),
                    SubText(
                      text: " • ${stepLabels[deliStatus - 1].tr()}",
                      color: AppColors.success,
                      fontSize: FontSizes.sm,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItemList(List orderItems, int deliStatus) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: orderItems.length * 70.0,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: orderItems.length,
        itemBuilder: (context, index) {
          final item = orderItems[index];
          final quantity = item["quantity"] ?? 0;
          final price = item["price"] ?? 0.0;
          return OrderItem(
            item: item,
            quantity: quantity,
            price: price,
            deliStatus: deliStatus,
          );
        },
      ),
    );
  }

  Widget _buildCompletedOrderInfo(String orderStatus, int deliStatus) {
    if (orderStatus != "completed") return const SizedBox();

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.neutral30, width: 1),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RenderSvgIcon(
                        assetName: "assets/icons/truck_icon.svg",
                        color: _orderStatusColor(orderStatus),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      SubText(
                        text: "order.deli_info".tr(),
                        color: AppColors.neutral90,
                      ),
                    ],
                  ),
                  CustomBadge(
                    label: stepLabels[deliStatus - 1].tr(),
                    color: _deliStatusColor(deliStatus),
                    variant: BadgeVariant.outlined,
                    fontSize: 12,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _buildDriverInfoRow(widget.selectedOrder.orderItems.length, deliStatus),
              const SizedBox(height: 12),
              Row(
                children: [
                  RenderSvgIcon(
                    assetName: "assets/icons/phone_icon.svg",
                    color: AppColors.textPrimary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  SubText(text: "+95945653456", color: AppColors.textPrimary)
                ],
              ),
              const Divider(color: AppColors.neutral30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      RenderSvgIcon(
                        assetName: "assets/icons/check_circle1.svg",
                        color: _deliStatusColor(deliStatus),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      SubText(
                        text: "order.delivered".tr(),
                        color: AppColors.success,
                        fontSize: FontSizes.sm,
                      ),
                    ],
                  ),
                  SubText(
                    text: "order.thank".tr(),
                    color: AppColors.neutral70,
                    fontSize: FontSizes.sm,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.selectedOrder;
    final orderStatus = order.status;
    final deliStatus = order.deliStatus;
    final totalItems = order.orderItems.length;
    final orderItems = order.orderItems;

    if (orderStatus == "cancelled") return const CancelledStatus();

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              RenderSvgIcon(
                assetName: "assets/icons/truck_icon.svg",
                color: AppColors.neutral70,
                size: 18,
              ),
              const SizedBox(width: 8),
              SubText(
                text: "order.deli_status".tr(),
                color: AppColors.neutral90,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0.5,
            color: AppColors.background,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border(
                  left: BorderSide(color: AppColors.neutral40, width: 6),
                  top: BorderSide(color: AppColors.neutral40, width: 1),
                  right: BorderSide(color: AppColors.neutral40, width: 1),
                  bottom: BorderSide(color: AppColors.neutral40, width: 1),
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButtonTwoWidget(
                        icon: "assets/icons/cube.svg",
                        onTap: () {},
                        iconColor: _deliStatusColor(deliStatus),
                        bgColor:
                            _deliStatusColor(deliStatus).withValues(alpha: .1),
                        iconSize: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(
                              text: stepLabels[deliStatus - 1].tr(),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _deliStatusColor(deliStatus),
                            ),
                            const SizedBox(height: 4),
                            SubText(
                              text: "order.prep_des".tr(),
                              color: AppColors.neutral70,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),
                      CustomBadge(
                        label: "$totalItems items",
                        color: _deliStatusColor(deliStatus),
                        variant: BadgeVariant.outlined,
                        borderColor: AppColors.neutral40,
                        backgroundColor: AppColors.neutral10,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: _buildStepper(deliStatus),
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () => setState(() => _isExpanded = !_isExpanded),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: AppColors.neutral30, width: 1),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildDriverInfoRow(totalItems, deliStatus),
                                ),
                                Row(
                                  children: [
                                    RenderSvgIcon(
                                      assetName: "assets/icons/phone_icon.svg",
                                      color: AppColors.success,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 16),
                                    Transform.rotate(
                                      angle: _isExpanded ? 3.1416 : 0,
                                      child: RenderSvgIcon(
                                        assetName:
                                            "assets/icons/chevron_down.svg",
                                        color: AppColors.neutral60,
                                        size: 6,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ExpandedSection(
                            expand: _isExpanded,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(color: AppColors.neutral40),
                                  const SizedBox(height: 8),
                                  _buildCompletedOrderInfo(orderStatus, deliStatus),
                                  SubText(
                                    text: "Items in this group:",
                                    fontSize: FontSizes.sm,
                                  ),
                                  const SizedBox(height: 8),
                                  _buildOrderItemList(orderItems, deliStatus),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildStepper(int currentStep) {
  return Column(
    children: [
      Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(height: 2, color: AppColors.neutral30),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final totalWidth = constraints.maxWidth;
                  final progressWidth = totalWidth * ((currentStep - 1) / 3);

                  return Container(
                    height: 2,
                    width: currentStep == 1 ? 20 : progressWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _deliStatusColor(1),
                          if (currentStep >= 2) _deliStatusColor(2),
                          if (currentStep >= 3) _deliStatusColor(3),
                          if (currentStep >= 4) _deliStatusColor(4),
                        ],
                        stops: [
                          0.0,
                          if (currentStep >= 2) 1.0 / (currentStep - 1),
                          if (currentStep >= 3) 2.0 / (currentStep - 1),
                          if (currentStep >= 4) 3.0 / (currentStep - 1),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                final step = index + 1;
                final isCompleted = step < currentStep;
                final isActive = step == currentStep;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isCompleted || isActive
                                ? _deliStatusColor(step)
                                : AppColors.neutral30,
                      ),
                      child: Center(
                        child: Text(
                          step.toString(),
                          style: TextStyle(
                            color:
                                isCompleted || isActive
                                    ? AppColors.textLight
                                    : AppColors.textSecondary,
                            fontSize: FontSizes.sm,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stepLabels[index].tr(),
                      style: TextStyle(
                        fontSize: 11,
                        color:
                            isCompleted || isActive
                                ? _deliStatusColor(step)
                                : AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    ],
  );
}

Color _deliStatusColor(int status) {
  switch (status) {
    case 1:
      return AppColors.purple;
    case 2:
      return Colors.indigoAccent;
    case 3:
      return Colors.blue;
    case 4:
      return AppColors.success;
    default:
      return AppColors.success;
  }
}

Color _orderStatusColor(String status) {
  switch (status.toLowerCase()) {
    case "confirmed":
      return AppColors.primaryDark;
    case "completed":
      return Colors.indigoAccent;
    case "pending":
      return AppColors.yello500;
    case "shipped":
      return Colors.purpleAccent;
    case "rejected":
      return Colors.red;
    case "cancelled":
      return Colors.red;
    default:
      return AppColors.neutral40;
  }
}