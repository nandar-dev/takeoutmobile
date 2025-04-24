import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/services/product_service.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/cards/product_card.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class RelatedProducts extends StatefulWidget {
  final int productId;
  final int merchantId;

  const RelatedProducts({
    super.key,
    required this.productId,
    required this.merchantId,
  });

  @override
  State<RelatedProducts> createState() => _RelatedProductsState();
}

class _RelatedProductsState extends State<RelatedProducts> {
  List<Product> relatedProducts = [];
  bool isLoading = true;

  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    loadRelatedProducts();
  }

  Future<void> loadRelatedProducts() async {
    try {
      final loadedRelatedProducts = await _productService.getRelatedProducts(
        widget.productId,
      );
      setState(() {
        relatedProducts = loadedRelatedProducts;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading related products: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = "product.recommend".tr();
    final btnLabel = "button.see_all".tr();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubText(
              text: title,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: FontSizes.md,
            ),
            GestureDetector(
              onTap:
                  () => Navigator.pushNamed(
                    context,
                    AppRoutes.merchantProducts,
                    arguments: {'merchantId': widget.merchantId},
                  ),
              child: SubText(
                text: btnLabel,
                color: AppColors.primary,
                fontSize: FontSizes.body,
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                isLoading
                    ? [const CircularProgressIndicator()]
                    : relatedProducts.map((product) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 180,
                          child: ProductCard(product: product),
                        ),
                      );
                    }).toList(),
          ),
        ),
      ],
    );
  }
}
