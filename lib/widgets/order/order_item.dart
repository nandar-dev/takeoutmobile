import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/render_svg_icon.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.item,
    required this.quantity,
    required this.price,
    required this.deliStatus,
    this.backgroundColor,
  });

  final dynamic item;
  final dynamic quantity;
  final dynamic price;
  final int deliStatus;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.neutral20,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: AppColors.neutral40)
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .05),
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: RenderSvgIcon(
              assetName: "assets/icons/cube.svg",
              color: AppColors.neutral50,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubText(
                  text: item['name'] ?? '',
                  fontSize: FontSizes.md,
                  color: AppColors.textPrimary,
                ),
                SubText(
                  text: "Qty: $quantity • ${price.toStringAsFixed(2)}",
                  fontSize: FontSizes.sm,
                  color: AppColors.neutral70,
                ),
              ],
            ),
          ),
          SubText(
            textAlign: TextAlign.end,
            text: (quantity * price).toStringAsFixed(2),
            fontSize: FontSizes.md,
            color: _deliStatusColor(deliStatus),
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
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