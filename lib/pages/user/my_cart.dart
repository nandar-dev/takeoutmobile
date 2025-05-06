import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/bloc/cart/bloc.dart';
import 'package:takeout/bloc/cart/event.dart';
import 'package:takeout/bloc/cart/state.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/outlinebutton_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/cards/order_item_card.dart';
import 'package:takeout/widgets/cart/empty_cart.dart';
import 'package:takeout/widgets/cart/payment_summary.dart';
import 'package:takeout/widgets/loading/loading_indicator.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartBloc>().add(LoadCart());
    });
  }

  Future<void> _refreshCart() async {
    context.read<CartBloc>().add(LoadCart());
  }

  @override
  Widget build(BuildContext context) {
    final locationLabel = "cart.location_label".tr();
    final title = "title.cart".tr();
    final addMoreBtnLabel = "button.add_more".tr();
    final locationBtnLabel = "button.change_location".tr();

    return Scaffold(
      backgroundColor: AppColors.appbarBackground,
      appBar: AppBarWidget(
        title: title,
        onBackTap: () => Navigator.pushNamed(context, AppRoutes.appNavigation),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (state is CartLoaded) {
            final cartItems = state.items;

            if (cartItems.isEmpty) {
              return const EmptyCart();
            }

            return Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshCart,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SubText(
                                        text: locationLabel,
                                        fontSize: FontSizes.sm,
                                      ),
                                      SubText(
                                        text: "Yangon",
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.md,
                                      ),
                                    ],
                                  ),
                                ),
                                CustomOutlinedButton(
                                  onPressed: () {},
                                  text: locationBtnLabel,
                                  borderColor: AppColors.primary,
                                  textColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final item = cartItems[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              child: OrderItemCard(item: item),
                            );
                          }, childCount: cartItems.length),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 16)),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Align(
                              alignment: Alignment.center,
                              child: CustomOutlinedButton(
                                onPressed:
                                    () => Navigator.pushNamed(
                                      context,
                                      AppRoutes.products,
                                      arguments: {'categoryId': null},
                                    ),
                                text: addMoreBtnLabel,
                                borderRadius: 5,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                icon: Icons.add,
                                borderColor: AppColors.neutral40,
                              ),
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 100)),
                      ],
                    ),
                  ),
                ),
                _buildPaymentSummarySection(context, cartItems),
              ],
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  Widget _buildPaymentSummarySection(
    BuildContext context,
    List<Map<String, dynamic>> cartItems,
  ) {
    final btnLabel = "button.proceed_payment".tr();
    return Container(
      constraints: BoxConstraints(
        minHeight: 200,
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      decoration: BoxDecoration(color: AppColors.background),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PaymentSummary(items: cartItems),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: CustomPrimaryButton(
              onPressed:
                  () => Navigator.pushNamed(context, AppRoutes.selectPayment),
              text: btnLabel,
            ),
          ),
        ],
      ),
    );
  }
}
