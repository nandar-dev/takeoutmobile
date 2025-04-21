import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class PaymentSummary extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final bool? showTitle;

  const PaymentSummary({super.key, required this.items, this.showTitle = true});

  double _calculateSubtotal() {
    return items.fold(
      0.0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = _calculateSubtotal();
    const shipping = 0.00;
    final total = subtotal + shipping;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: AppColors.neutral30, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(showTitle == true) TitleText(text: 'Payment Summary', fontSize: FontSizes.heading3),
          _buildSummaryRow('Total items(${items.length})', subtotal),
          _buildSummaryRow('Delivery Fee', shipping),
          _buildSummaryRow('Total', total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SubText(
            text: label,
            fontSize: FontSizes.md,
            color: AppColors.neutral70,
          ),
          SubText(
            text: value == 0 ? 'Free' : '\$${value.toStringAsFixed(2)}',
            fontSize: FontSizes.md,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}
