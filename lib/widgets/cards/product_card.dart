import 'package:flutter/material.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/iconbutton_two_widget.dart';
import 'package:takeout/widgets/render_network_image.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isLoved = false;

  void toggleLove() {
    setState(() {
      isLoved = !isLoved;
    });
    debugPrint('${isLoved ? 'Loved' : 'Unloved'}: ${widget.product.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: .5,
      color: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with heart button
            Stack(
              children: [
                RenderNetworkImage(
                  imageUrl: widget.product.imageUrl,
                  height: 110,
                  width: double.infinity,
                  rounded: 8,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButtonTwoWidget(
                    icon: isLoved
                        ? 'assets/icons/heart_fill.svg'
                        : 'assets/icons/heart.svg',
                    bgColor: AppColors.background,
                    active: isLoved,
                    activeColor: AppColors.danger,
                    iconColor: AppColors.danger,
                    onTap: toggleLove,
                  ),
                ),
              ],
            ),
            
            // Product details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 3),
                SubText(
                  text: widget.product.name,
                  color: AppColors.textPrimary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SubText(
                  text: widget.product.shopName,
                  fontSize: FontSizes.body,
                  color: AppColors.textSecondary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                SubText(
                  text: "\$${widget.product.price.toStringAsFixed(2)}",
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
