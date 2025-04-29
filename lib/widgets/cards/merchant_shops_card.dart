import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/models/shop_model.dart';
import 'package:takeout/services/shop_service.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/check_shop_status.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/custom_text_button.dart';
import 'package:takeout/widgets/cards/shop_card.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class MerchantShopsCard extends StatefulWidget {
  const MerchantShopsCard({super.key});

  @override
  State<MerchantShopsCard> createState() => _MerchantShopsCardState();
}

class _MerchantShopsCardState extends State<MerchantShopsCard> {
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
    final chevronRightIcon = "assets/icons/chevron_right.svg";
    final title = "merchant_home.shop_title".tr();

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
          children: [
            // Top Title and Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleText(
                  text: title,
                  color: AppColors.neutral80,
                  fontSize: FontSizes.heading3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                CustomTextButton(
                  btnLabel: "button.add_new".tr(),
                  onTapCallback: () {
                    debugPrint('Add new shop clicked');
                  },
                  textColor: AppColors.primaryDark,
                  iconColor: AppColors.primaryDark,
                  endSvgIcon: chevronRightIcon,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Shops list
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : shops.isEmpty
                ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: SubText(
                    text: "No shops found.",
                    color: AppColors.neutral50,
                    fontSize: FontSizes.body,
                  ),
                )
                : SizedBox(
                  height: 170,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: shops.length,
                    separatorBuilder:
                        (context, index) => const SizedBox(width: 1),
                    itemBuilder: (context, index) {
                      final shop = shops[index];
                      final status = checkShopStatus(
                        shop.openingTime,
                        shop.closingTime,
                      );

                      return ShopCard(
                        name: shop.name,
                        imageUrl: shop.imageUrl,
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
    );
  }
}
