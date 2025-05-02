import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/cards/product_card_2.dart';
import 'package:takeout/widgets/product/product_filters.dart';
import 'package:takeout/services/product_service.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, this.categoryId});

  final int? categoryId;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [];
  bool isLoading = true;
  final String title = "title.product".tr();
  final String sortBtnLabel = "Sort";
  final String offerBtnLabel = "Offer";
  final String shopBtnLabel = "Shop";
  final String chevronDownIcon = "assets/icons/chevron_down.svg";
  final String filterBtnIcon = "assets/icons/filter.svg";

  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final loadedProducts = await _productService.loadProducts();
      setState(() {
        products = loadedProducts;
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
    return Scaffold(
      appBar: AppBarWidget(title: title, borderedBack: false, onBackTap: () => Navigator.pushNamed(context, AppRoutes.appNavigation),),
      body: Column(
        children: [
          // sorting group
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: AppColors.neutral30,
                    width: 1,
                  ),
                ),
              ),
              child: ProductFilters(filterBtnIcon: filterBtnIcon, sortBtnLabel: sortBtnLabel, chevronDownIcon: chevronDownIcon, offerBtnLabel: offerBtnLabel, shopBtnLabel: shopBtnLabel),
            ),
          ),
          // products list
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemCount: products.length,
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ProductCard2(
                          onTabProduct: true,
                          product: product,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
