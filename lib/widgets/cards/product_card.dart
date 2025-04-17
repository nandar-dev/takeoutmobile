import 'package:flutter/material.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/iconbutton_two_widget.dart';
import 'package:takeout/widgets/render_custom_image.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isLoved = false;
  final heartFilledIcon = 'assets/icons/heart_fill.svg';
  final heartOutlinedIcon = 'assets/icons/heart.svg';

  void toggleLove() {
    setState(() {
      isLoved = !isLoved;
    });
    debugPrint('${isLoved ? 'Loved' : 'Unloved'}: ${widget.product.name}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.pushNamed(
            context,
            AppRoutes.product,
            arguments: {'product': widget.product},
          ),
      child: Card(
        elevation: .5,
        color: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  RenderCustomImage(
                    imageUrl: widget.product.imageUrl,
                    height: 110,
                    width: double.infinity,
                    rounded: 8,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButtonTwoWidget(
                      buttonSize: 35,
                      icon: isLoved ? heartFilledIcon : heartOutlinedIcon,
                      bgColor: AppColors.background,
                      active: isLoved,
                      activeColor: AppColors.danger,
                      iconColor: AppColors.danger,
                      onTap: toggleLove,
                      iconSize: 15,
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
      ),
    );
  }
}
