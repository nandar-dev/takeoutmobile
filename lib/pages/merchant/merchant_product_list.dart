import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/cards/product_card_2.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class MerchantProductList extends StatefulWidget {
  const MerchantProductList({super.key});

  @override
  State<MerchantProductList> createState() => _MerchantProductListState();
}

class _MerchantProductListState extends State<MerchantProductList> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/products.json');
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
    final title = "title.product".tr();
    final description = "product.merchant_product_description".tr();

    return Scaffold(
      appBar: AppBarWidget(title: title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubText(text: description),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      itemCount: products.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return ProductCard2(
                          product: products[index],
                          addDiscountCallback: () {
                            final product = products[index];
                            Navigator.pushNamed(
                              context,
                              AppRoutes.addDiscount,
                              arguments: {
                                'productId': product.id,
                                'name': product.name,
                                'price': product.price,
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
