import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:takeout/cubit/product/product_cubit.dart';
import 'package:takeout/cubit/product/product_state.dart';
import 'package:takeout/data/models/product_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/widgets/buttons/custom_text_button.dart';
import 'package:takeout/widgets/cards/product_card.dart';

class ProductSection extends StatefulWidget {
  const ProductSection({super.key, required this.seeBtnLabel});

  final String seeBtnLabel;

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadInitialProducts();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadInitialProducts() async {
    await context.read<ProductCubit>().loadProducts(pageSize: 4);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    const threshold = 0; // Load more when 100px from bottom

    if (maxScroll - currentScroll <= threshold) {
      _loadMoreProducts();
    }
  }

  Future<void> _loadMoreProducts() async {
    if (_isLoadingMore) return;

    final cubit = context.read<ProductCubit>();
    if (!cubit.hasMore) return;

    setState(() => _isLoadingMore = true);
    await cubit.loadProducts(isLoadMore: true, pageSize: 4);
    setState(() => _isLoadingMore = false);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is ProductLoading;
        final products = _getProducts(state);
        final canLoadMore =
            state is ProductLoaded && context.read<ProductCubit>().hasMore;

        return Column(
          children: [
            const SizedBox(height: 12),
            _buildHeader(),
            const SizedBox(height: 12),
            _buildProductGrid(isLoading, products, canLoadMore),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomTextButton(
          btnLabel: widget.seeBtnLabel,
          onTapCallback:
              () => Navigator.pushNamed(
                context,
                AppRoutes.products,
                arguments: {'categoryId': null},
              ),
        ),
      ],
    );
  }

  Widget _buildProductGrid(
    bool isLoading,
    List<ProductModel> products,
    bool canLoadMore,
  ) {
    final itemCount = products.length + (canLoadMore ? 1 : 0);

    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        children: [
          GridView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(5),
            itemCount: itemCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 3 / 3.5,
            ),
            itemBuilder: (context, index) {
              if (index >= products.length) {
                return _buildLoadMoreWidget();
              }
              final product = products[index];
              return ProductCard(
                product: product,
                onTapCallback:
                    () => Navigator.pushNamed(
                      context,
                      AppRoutes.product,
                      arguments: {'product': product},
                    ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMoreWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            _isLoadingMore
                ? const CircularProgressIndicator()
                : TextButton(
                  onPressed: _loadMoreProducts,
                  child: const Text('Load More'),
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
