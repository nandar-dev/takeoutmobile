import 'package:flutter/material.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/render_custom_image.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ProductCard2 extends StatelessWidget {
  const ProductCard2({super.key, required this.product});

  final Product product;

  // Reusable TextStyle for SubText
  TextStyle get subTextStyle => TextStyle(
    fontSize: FontSizes.md,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.bold,
    overflow: TextOverflow.ellipsis,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.primary.withValues(alpha: .2),
      onTap:
          () => Navigator.pushNamed(
            context,
            AppRoutes.product,
            arguments: {'product': product},
          ),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neutral30, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            // Product Image Section
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: RenderCustomImage(
                imageUrl: product.imageUrl,
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(width: 12),

            // Product Information Section
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name & Shop Name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubText(
                        text: product.name,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSizes.md,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      SubText(
                        text: product.shopName,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSizes.md,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),

                  // Product Price
                  SubText(
                    text: "\$${product.price.toString()}",
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSizes.heading3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
