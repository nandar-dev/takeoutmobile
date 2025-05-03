import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/product/product_cubit.dart';
import 'package:takeout/cubit/product/product_state.dart';
import 'package:takeout/data/models/product_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/custom_text_button.dart';
import 'package:takeout/widgets/cards/product_card.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class AvailableProductsCard extends StatelessWidget {
  const AvailableProductsCard({super.key});

  final String chevronRightIcon = "assets/icons/chevron_right.svg";

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
            TitleText(
              text: title,
              color: AppColors.neutral80,
              fontSize: FontSizes.heading3,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextButton(
                  btnLabel: "button.see_all".tr(),
                  onTapCallback:
                      () => Navigator.pushNamed(
                        context,
                        AppRoutes.merchantProductList,
                      ),
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
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final products = _getProducts(state);
                if (products.isEmpty) {
                  return Center(child: Text("No products available"));
                }

                return SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return SizedBox(
                        width: 180,
                        child: ProductCard(product: product),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<ProductModel> _getProducts(ProductState state) {
    if (state is ProductLoaded || state is ProductLoadingMore) {
      return state.products;
    }
    if (state is ProductError) return [];
    return ProductLoader().getLoadingProducts(4);
  }
}
