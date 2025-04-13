import 'package:flutter/material.dart';
import 'package:takeout/models/shop_model.dart';
import 'package:takeout/services/shop_service.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/check_shop_status.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/utils/horizontal_sliding_handler.dart';
import 'package:takeout/widgets/cards/shop_card.dart';
import 'package:takeout/widgets/iconbutton_two_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class NearbyShopsSection extends StatefulWidget {
  const NearbyShopsSection({
    super.key,
    required this.sectionTitle,
    required this.chevronLeftIcon,
    required this.chevronRightIcon,
  });

  final String chevronLeftIcon;
  final String chevronRightIcon;
  final String sectionTitle;

  @override
  State<NearbyShopsSection> createState() => _NearbyShopsSectionState();
}

class _NearbyShopsSectionState extends State<NearbyShopsSection> {
  List<Shop> shops = [];
  final ScrollController _scrollController = ScrollController();
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
    return Column(
      children: [
        // Title Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubText(
              text: widget.sectionTitle,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: FontSizes.body1,
            ),
            Row(
              children: [
                IconButtonTwoWidget(
                  icon: widget.chevronLeftIcon,
                  onTap:
                      () => horizontalSlidingHandler(
                        ScrollDirection.left,
                        _scrollController,
                      ),
                ),
                const SizedBox(width: 8),
                IconButtonTwoWidget(
                  icon: widget.chevronRightIcon,
                  onTap:
                      () => horizontalSlidingHandler(
                        ScrollDirection.right,
                        _scrollController,
                      ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Shops list
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children:
                    shops.map((shop) {
                      String status = checkShopStatus(
                        shop.openingTime,
                        shop.closingTime,
                      );

                      return ShopCard(
                        name: shop.name,
                        imageUrl: shop.imageUrl,
                        status: status,
                        onTap: () {
                          debugPrint("you clicked ${shop.name}");
                        },
                      );
                    }).toList(),
              ),
            ),
      ],
    );
  }
}
