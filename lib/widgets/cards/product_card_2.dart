import 'package:flutter/material.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/render_custom_image.dart';
import 'package:takeout/widgets/render_svg_icon.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ProductCard2 extends StatelessWidget {
  const ProductCard2({
    super.key,
    required this.product,
    this.addDiscountCallback,
    this.onTabProduct = false,
  });

  final Product product;
  final bool? onTabProduct;
  final VoidCallback? addDiscountCallback;

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
      onTap: onTabProduct == true
      ? () => Navigator.pushNamed(
          context,
          AppRoutes.product,
          arguments: {'product': product},
        )
      : null,
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
                        text: product.shop.name,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubText(
                        text: "\$${product.price.toString()}",
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSizes.heading3,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if(addDiscountCallback != null) DiscountBtn(onTap: addDiscountCallback),
                    ],
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

class DiscountBtn extends StatelessWidget {
  final VoidCallback? onTap;

  const DiscountBtn({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: .25),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          splashColor: AppColors.primaryDark.withValues(alpha: .2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                RenderSvgIcon(
                  assetName: "assets/icons/discount.svg",
                  color: AppColors.textLight,
                  size: 16,
                ),
                const SizedBox(width: 4),
                SubText(
                  text: "Add Discount",
                  fontSize: FontSizes.sm,
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
