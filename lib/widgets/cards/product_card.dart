import 'package:flutter/material.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/render_network_image.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: RenderNetworkImage(
              imageUrl: product.imageUrl,
              height: 110,
              width: double.infinity,
              rounded: 8,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubText(text: product.name, color: AppColors.textPrimary, maxLines: 1, overflow: TextOverflow.ellipsis,),
                  SubText(
                    text: product.shopName,
                    fontSize: FontSizes.body,
                    color: AppColors.textSecondary,
                    maxLines: 1, overflow: TextOverflow.ellipsis
                  ),
                  SizedBox(height: 3),
                  SubText(
                    text: "\$${product.price.toStringAsFixed(2)}",
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
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
