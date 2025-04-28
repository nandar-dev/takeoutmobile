import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:takeout/bloc/cart/bloc.dart';
import 'package:takeout/bloc/cart/state.dart';
import 'package:takeout/pages/user/my_cart.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/buttons/iconbutton_two_widget.dart';
import 'package:takeout/widgets/buttons/outlinebutton_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/cart/payment_summary.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class Selectpayment extends StatefulWidget {
  const Selectpayment({super.key});

  @override
  State<Selectpayment> createState() => _SelectpaymentState();
}

class _SelectpaymentState extends State<Selectpayment> {
  String _selectedMethod = 'wallet';

  void _setPaymentMethod(String method) {
    setState(() {
      _selectedMethod = method;
    });
  }

  Widget _buildPaymentOption({
    required String methodKey,
    required String iconPath,
    required String title,
    required String subtitle,
  }) {
    final bool isSelected = _selectedMethod == methodKey;

    return GestureDetector(
      onTap: () => _setPaymentMethod(methodKey),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primary.withValues(alpha: .05)
                  : AppColors.background,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.neutral30,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButtonTwoWidget(
                  icon: iconPath,
                  onTap: () => _setPaymentMethod(methodKey),
                  bgColor: AppColors.primary.withValues(alpha: 0.1),
                  iconSize: 20,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubText(
                      text: title,
                      color: AppColors.textPrimary,
                      fontSize: FontSizes.md,
                    ),
                    if (subtitle.isNotEmpty)
                      SubText(text: subtitle, fontSize: FontSizes.sm),
                  ],
                ),
              ],
            ),
            if (isSelected == true)
              SvgPicture.asset(
                "assets/icons/check_circle.svg",
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = "title.payment".tr();
    final orderSummary = "cart.order_label".tr();
    final walletBal = "cart.wallet_balance".tr();
    final currentBal = "cart.current_balance".tr();
    final refillWal = "button.refill_wallet".tr();
    final paymentMethodLabel = "cart.methods".tr();
    final wallet = "cart.wallet".tr();
    final cash = "cart.cash".tr();
    final btnLabel = "button.place_order".tr();
    final walletSubtitle = "cart.wallet_warning".tr();
    final cashSubtitle = "cart.cash_description".tr();


    return Scaffold(
      appBar: AppBarWidget(
        title: title,
        onBackTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyCart()),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TitleText(
                  text: orderSummary,
                  fontSize: FontSizes.md,
                ),
              ),
              const SizedBox(height: 12),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return PaymentSummary(items: state.items, showTitle: false);
                  } else if (state is CartLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CartError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: TitleText(text: walletBal, fontSize: FontSizes.md),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border.all(color: AppColors.neutral30, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButtonTwoWidget(
                              icon: "assets/icons/wallet_icon.svg",
                              onTap: () {},
                              bgColor: AppColors.background,
                            ),
                            const SizedBox(width: 5),
                            SubText(text: currentBal),
                          ],
                        ),
                        TitleText(
                          text: "\$ 0.00",
                          fontSize: FontSizes.md,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: CustomOutlinedButton(
                        iconColor: AppColors.primary,
                        textColor: AppColors.primary,
                        borderColor: AppColors.primary,
                        svgAssetPath: "assets/icons/refresh_icon.svg",
                        borderRadius: 5,
                        onPressed:
                            () => Navigator.pushNamed(
                              context,
                              AppRoutes.refillwallet,
                            ),
                        text: refillWal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: TitleText(
                  text: paymentMethodLabel,
                  fontSize: FontSizes.md,
                ),
              ),
              const SizedBox(height: 10),
              _buildPaymentOption(
                methodKey: 'wallet',
                iconPath: "assets/icons/wallet_icon.svg",
                title: wallet,
                subtitle: walletSubtitle,
              ),
              _buildPaymentOption(
                methodKey: 'cash',
                iconPath: "assets/icons/cash_icon.svg",
                title: cash,
                subtitle: cashSubtitle,
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: CustomPrimaryButton(
                  text: btnLabel,
                  onPressed: () {
                    // Handle placing the order
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
