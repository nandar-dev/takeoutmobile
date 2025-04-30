import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/widgets/home/category_section.dart';
import 'package:takeout/widgets/home/hero_section.dart';
import 'package:takeout/widgets/home/nearby_shops_section.dart';
import 'package:takeout/widgets/home/product_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          HeroSection(
            sectionHeight: 200,
            bgImg: bgImg
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              color: Colors.white,
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    // category section
                    CategorySection(
                      categorySectionTitle: categorySectionTitle,
                      seeBtnLabel: seeBtnLabel
                    ),
                    NearbyShopsSection(sectionTitle: nearbyTitle, chevronLeftIcon: chevronLeftIcon, chevronRightIcon: chevronRightIcon),
                    ProductSection(seeBtnLabel: seeBtnLabel),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
