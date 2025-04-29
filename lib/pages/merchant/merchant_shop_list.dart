import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/models/shop_model.dart';
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
  List<Shop> shops = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadShops();
  }

  Future<void> loadShops() async {
    shops = await ShopService.loadShops();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = "title.shop".tr();
    final poweredTitle = "title.merchant_shop".tr();
    final plusIcon = "assets/icons/plus_icon.svg";

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        surfaceTintColor: AppColors.primary,
        toolbarHeight: 10,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: HeroSection(
              sectionHeight: 220,
              bgColor: AppColors.primary,
              textColor: AppColors.textLight,
              iconColor: AppColors.textLight,
              title: poweredTitle,
            ),
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
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleText(text: title, fontSize: FontSizes.heading2),
                        IconButtonTwoWidget(
                          icon: plusIcon,
                          onTap: () {},
                          bgColor: AppColors.primary,
                          iconColor: AppColors.textLight,
                          iconSize: 15,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child:
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : shops.isEmpty
                            ? const Center(child: Text("No shops found."))
                            : GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              itemCount: shops.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 1,
                                    crossAxisSpacing: 1,
                                    childAspectRatio: 1.08,
                                  ),
                              itemBuilder: (context, index) {
                                final shop = shops[index];
                                final status = checkShopStatus(
                                  shop.openingTime,
                                  shop.closingTime,
                                );

                                return ShopCard(
                                  name: shop.name,
                                  imageUrl: shop.imageUrl,
                                  width: double.infinity,
                                  status: status,
                                  onTap: () {
                                    debugPrint("Clicked ${shop.name}");
                                  },
                                  showStatus: false,
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
