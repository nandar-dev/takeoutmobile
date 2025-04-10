import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/appbar_sidget_2.dart';
import 'package:takeout/widgets/cards/product_card_2.dart';
import 'package:takeout/widgets/sort_button.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, this.categoryId});

  final int? categoryId;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [];
  bool isLoading = true;
  final String title = "Products List";
  final String sortBtnLabel = "Sort";
  final String offerBtnLabel = "Offer";
  final String shopBtnLabel = "Shop";
  final String chevronDownIcon = "assets/icons/chevron_down.svg";
  final String filterBtnIcon = "assets/icons/filter.svg";

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
    return Scaffold(
      appBar: AppbarWidget2(title: title),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SortButton(
                    onTap: () {
                      // Sorting functionality here
                    },
                    iconHeight: 12,
                    iconWeight: 12,
                    icon: filterBtnIcon,
                    angleVal: 90 * (3.1416 / 180),
                  ),
                  SizedBox(width: 5),
                  SortButton(
                    onTap: () {
                      // Sorting functionality here
                    },
                    label: sortBtnLabel,
                    icon: chevronDownIcon,
                  ),
                  SizedBox(width: 5),
                  SortButton(
                    onTap: () {
                      // Sorting functionality here
                    },
                    label: offerBtnLabel,
                    icon: chevronDownIcon,
                  ),
                  SizedBox(width: 5),
                  SortButton(
                    onTap: () {
                      // Sorting functionality here
                    },
                    label: shopBtnLabel,
                    icon: chevronDownIcon,
                  ),
                ],
              ),
            ),
          ),
          // products list using ListView.separated
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemCount: products.length,
                    separatorBuilder: (context, index) => SizedBox(height: 10,),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ProductCard2(
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
