import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:takeout/cubit/product/product_cubit.dart';
import 'package:takeout/cubit/product/product_state.dart';
import 'package:takeout/data/models/product_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/cards/product_card_2.dart';
import 'package:takeout/widgets/loading/loading_indicator.dart';
import 'package:takeout/widgets/product/product_filters.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, this.categoryId});

  final int? categoryId;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ScrollController _scrollController = ScrollController();
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().loadProducts(pageSize: _pageSize);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !context.read<ProductCubit>().isLoadingMore &&
          context.read<ProductCubit>().hasMore) {
        context.read<ProductCubit>().loadProducts(
          isLoadMore: true,
          pageSize: _pageSize,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String title = "title.product".tr();
    final String sortBtnLabel = "Sort";
    final String offerBtnLabel = "Offer";
    final String shopBtnLabel = "Shop";
    final String chevronDownIcon = "assets/icons/chevron_down.svg";
    final String filterBtnIcon = "assets/icons/filter.svg";

    return Scaffold(
      appBar: AppBarWidget(
        title: title,
        borderedBack: false,
        onBackTap:
            () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.appNavigation,
              (route) => false,
            ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final bool isLoading = state is ProductLoading;
          final bool isLoadingMore = state is ProductLoadingMore;
          final hasError = state is ProductError;
          final products = _getProducts(state);

          return Column(
            children: [
              _buildProductFilter(
                filterBtnIcon,
                sortBtnLabel,
                chevronDownIcon,
                offerBtnLabel,
                shopBtnLabel,
              ),
              _buildProductList(isLoading, isLoadingMore, hasError, products),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductFilter(
    filterBtnIcon,
    sortBtnLabel,
    chevronDownIcon,
    offerBtnLabel,
    shopBtnLabel,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(color: AppColors.neutral30, width: 1),
          ),
        ),
        child: ProductFilters(
          filterBtnIcon: filterBtnIcon,
          sortBtnLabel: sortBtnLabel,
          chevronDownIcon: chevronDownIcon,
          offerBtnLabel: offerBtnLabel,
          shopBtnLabel: shopBtnLabel,
        ),
      ),
    );
  }

  Widget _buildProductList(
    bool isLoading,
    bool isLoadingMore,
    bool hasError,
    List<ProductModel> products,
  ) {
    return Expanded(
      child: Skeletonizer(
        enabled: isLoading || isLoadingMore,
        child:
            hasError
                ? _buildErrorWidget()
                : ListView.separated(
                  controller: _scrollController,
                  itemCount: products.length + (isLoadingMore ? 1 : 0),
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    if (index >= products.length) {
                      return const Center(child: LoadingIndicator());
                    }
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ProductCard2(product: product),
                    );
                  },
                ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Text(
        'Failed to load products',
        style: TextStyle(color: AppColors.danger),
      ),
    );
  }

  List<ProductModel> _getProducts(ProductState state) {
    if (state is ProductLoaded) return state.products;
    if (state is ProductError) return [];
    return ProductLoader().getLoadingProducts(5);
  }
}
