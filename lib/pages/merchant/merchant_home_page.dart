import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/cards/available_products_card.dart';
import 'package:takeout/widgets/cards/deli_management_card.dart';
import 'package:takeout/widgets/cards/merchant_revenue.dart';
import 'package:takeout/widgets/cards/merchant_shops_card.dart';
import 'package:takeout/widgets/cards/order_card.dart';
import 'package:takeout/widgets/cards/wallet_card.dart';
import 'package:takeout/widgets/home/hero_section.dart';

class MerchantHomePage extends StatelessWidget {
  const MerchantHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final chevronDownIcon = 'assets/icons/chevron_down.svg';
    final locationIcon = 'assets/icons/location.svg';
    final notiIcon = 'assets/icons/noti.svg';
    final searchIcon = 'assets/icons/search.svg';
    final orderLabelOne = "merchant_home.running_order".tr();
    final orderLabelTwo = "merchant_home.order_req".tr();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 32),
          HeroSection(
            chevronDownIcon: chevronDownIcon,
            locationIcon: locationIcon,
            searchIcon: searchIcon,
            notiIcon: notiIcon,
            bgColor: AppColors.background,
            textColor: AppColors.textPrimary,
            iconColor: AppColors.textPrimary,
          ),
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const WalletCard(),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: OrderCard(
                          orderCount: "00",
                          label: orderLabelOne,
                          bgColor: AppColors.primaryDark.withAlpha(25),
                          mainColor: AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: OrderCard(
                          orderCount: "00",
                          label: orderLabelTwo,
                          bgColor: Colors.blueAccent.withAlpha(25),
                          mainColor: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const DeliManagementCard(),
                  const SizedBox(height: 12),
                  MerchantRevenue(),
                  const SizedBox(height: 12),
                  MerchantShopsCard(),
                  const SizedBox(height: 12),
                  AvailableProductsCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
