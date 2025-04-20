import 'package:flutter/material.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/cart/add_to_cart.dart';
import 'package:takeout/widgets/render_custom_image.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class OrderItemCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const OrderItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final product = Product.fromCartItem(item);
    final String name = item['name'] ?? 'Unnamed';
    final String imageUrl = item['imageUrl'] ?? '';
    final int quantity = item['quantity'] ?? 0;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutral30, width: 1),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.background,
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // Product image
          Container(
            decoration: BoxDecoration(
              color: AppColors.neutral10,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: RenderCustomImage(
              imageUrl: imageUrl,
              height: 100,
              width: 100,
            ),
          ),
          const SizedBox(width: 12),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubText(
                  text: name,
                  fontWeight: FontWeight.bold,
                  fontSize: FontSizes.md,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(height: 4),

                AddToCart(
                  product: product,
                  isDetailPage: false,
                  initialQuantity: quantity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
