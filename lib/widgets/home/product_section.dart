import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/cards/product_card.dart';

import '../typography_widgets.dart';

class ProductSection extends StatefulWidget {
  const ProductSection({super.key, required this.seeBtnLabel});

  final String seeBtnLabel;

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/products.json',
      );
      final List<dynamic> jsonResponse = json.decode(jsonString);
      setState(() {
        products = jsonResponse.map((data) => Product.fromJson(data)).toList();
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading products: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap:
                  () => Navigator.pushNamed(
                    context,
                    AppRoutes.products,
                    arguments: {'categoryId': null},
                  ),
              child: SubText(
                text: widget.seeBtnLabel,
                color: AppColors.primary,
                fontSize: FontSizes.body,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Loading indicator
        if (isLoading) const Center(child: CircularProgressIndicator()),

        // Grid view
        if (!isLoading)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(5),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 3 / 3.5,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          ),
      ],
    );
  }
}
