import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:takeout/cubit/product/product_cubit.dart';
import 'package:takeout/cubit/product/product_state.dart';
import 'package:takeout/data/models/product_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/widgets/buttons/custom_text_button.dart';
import 'package:takeout/widgets/cards/product_card.dart';
import 'package:takeout/widgets/home/category_section.dart';
import 'package:takeout/widgets/home/hero_section.dart';
import 'package:takeout/widgets/home/nearby_shops_section.dart';
import 'package:takeout/widgets/loading/loading_indicator.dart';
import 'package:takeout/widgets/toast_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    const threshold = 100;

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
    final chevronRightIcon = 'assets/icons/chevron_right.svg';
    final chevronLeftIcon = 'assets/icons/chevron_left.svg';
    final bgImg = 'assets/images/home_bg.png';
    final categorySectionTitle = "home.category_title".tr();
    final nearbyTitle = "home.shop_title".tr();
    final seeBtnLabel = "button.see_all".tr();

    return Scaffold(
      body: Column(
        children: [
          HeroSection(sectionHeight: 200, bgImg: bgImg),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  _onScroll();
                }
                return false;
              },
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                children: [
                  CategorySection(
                    categorySectionTitle: categorySectionTitle,
                    seeBtnLabel: seeBtnLabel,
                  ),
                  NearbyShopsSection(
                    sectionTitle: nearbyTitle,
                    chevronLeftIcon: chevronLeftIcon,
                    chevronRightIcon: chevronRightIcon,
                  ),
                  BlocConsumer<ProductCubit, ProductState>(
                    listener: (context, state) {
                      if (state is ProductError) {
                        showToast(message: state.message);
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is ProductLoading;
                      final products = _getProducts(state);
                      final canLoadMore = context.read<ProductCubit>().hasMore;

                      return Column(
                        children: [
                          const SizedBox(height: 12),
                          _buildHeader(seeBtnLabel),
                          const SizedBox(height: 12),
                          Skeletonizer(
                            enabled: isLoading,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: products.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 3 / 3.5,
                                  ),
                              itemBuilder: (context, index) {
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
                          ),
                          if (canLoadMore) _buildLoadMoreWidget(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String seeBtnLabel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomTextButton(
          btnLabel: seeBtnLabel,
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

  Widget _buildLoadMoreWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child:
            _isLoadingMore
                ? Column(
                  children: [
                    const SizedBox(height: 8),
                    const LoadingIndicator(),
                  ],
                )
                : const SizedBox(height: 40),
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
