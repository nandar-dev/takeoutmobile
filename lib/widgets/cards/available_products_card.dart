import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/models/product_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/custom_text_button.dart';
import 'package:takeout/widgets/cards/product_card.dart';
import 'package:takeout/widgets/typography_widgets.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class AvailableProductsCard extends StatefulWidget {
  const AvailableProductsCard({super.key});

  @override
  State<AvailableProductsCard> createState() => _AvailableProductsCardState();
}

class _AvailableProductsCardState extends State<AvailableProductsCard> {
  final String chevronRightIcon = "assets/icons/chevron_right.svg";

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
    final title = "merchant_home.product_title".tr();

    return Card(
      elevation: 1,
      color: AppColors.neutral10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: AppColors.neutral30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            TitleText(
              text: title,
              color: AppColors.neutral80,
              fontSize: FontSizes.heading3,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextButton(
                  btnLabel: "button.see_all".tr(),
                  onTapCallback: ()=> Navigator.pushNamed(context, AppRoutes.merchantProductList),
                  textColor: AppColors.primaryDark,
                  iconColor: AppColors.primaryDark,
                  endSvgIcon: chevronRightIcon,
                ),
                const SizedBox(width: 12),
                CustomTextButton(
                  btnLabel: "button.add_new".tr(),
                  onTapCallback: () {
                    debugPrint('Add new product clicked');
                  },
                  textColor: AppColors.primaryDark,
                  iconColor: AppColors.primaryDark,
                  endSvgIcon: chevronRightIcon,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Products list
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        products.map((product) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              width: 180,
                              child: ProductCard(
                                product: product,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
