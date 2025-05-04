import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/models/shop_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/services/shop_service.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/check_shop_status.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/iconbutton_two_widget.dart';
import 'package:takeout/widgets/cards/shop_card.dart';
import 'package:takeout/widgets/home/hero_section.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class MerchantShopList extends StatefulWidget {
  const MerchantShopList({super.key});

  @override
  State<MerchantShopList> createState() => _MerchantShopListState();
}

class _MerchantShopListState extends State<MerchantShopList> {
  Future<List<Shop>> _shopsFuture = ShopService.loadShops();

  @override
  void initState() {
    super.initState();
    _shopsFuture = ShopService.loadShops();
  }

  @override
  Widget build(BuildContext context) {
    final title = "title.shop".tr();
    final poweredTitle = "title.merchant_shop".tr();
    final plusIcon = "assets/icons/plus_icon.svg";

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          HeroSection(
            sectionHeight: 220,
            bgColor: AppColors.primary,
            textColor: AppColors.textLight,
            iconColor: AppColors.textLight,
            title: poweredTitle,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleText(text: title, fontSize: FontSizes.heading2),
                        IconButtonTwoWidget(
                          icon: plusIcon,
                          onTap: ()=> Navigator.pushNamed(context, AppRoutes.addShop),
                          bgColor: AppColors.primary,
                          iconColor: AppColors.textLight,
                          iconSize: 15,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<Shop>>(
                      future: _shopsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text("${'error.loading_shops'.tr()}: ${snapshot.error}"));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text("No shops found."));
                        }

                        final shops = snapshot.data!;
                        return GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: shops.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2.7,
                          ),
                          itemBuilder: (context, index) {
                            final shop = shops[index];
                            final status = checkShopStatus(shop.openingTime, shop.closingTime);

                            return ShopCard(
                              name: shop.name,
                              imageUrl: shop.imageUrl,
                              width: double.infinity,
                              status: status,
                              onTap: () => debugPrint("Clicked ${shop.name}"),
                              showStatus: false,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
