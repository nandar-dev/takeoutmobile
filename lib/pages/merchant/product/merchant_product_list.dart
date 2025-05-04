import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/product/product_cubit.dart';
import 'package:takeout/cubit/product/product_state.dart';
import 'package:takeout/data/models/product_model.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().loadProducts(isLoadMore: true, pageSize: 10);
  }

  @override
  Widget build(BuildContext context) {
    final title = "title.product".tr();
    final description = "product.merchant_product_description".tr();

    return Scaffold(
      appBar: AppBarWidget(title: title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            final isLoading = state is ProductLoading;
            final hasError = state is ProductError;
            final products = _getProducts(state);

            if (hasError) {
              return Center(child: Text("Failed to load products"));
            }

            return isLoading
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
                                  'name': product.pName,
                                  'price': product.pPrice,
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
          },
        ),
      ),
    );
  }

  List<ProductModel> _getProducts(ProductState state) {
    if (state is ProductLoaded || state is ProductLoadingMore) {
      return state.products;
    }
    if (state is ProductError) return [];
    return ProductLoader().getLoadingProducts(10);
  }
}
