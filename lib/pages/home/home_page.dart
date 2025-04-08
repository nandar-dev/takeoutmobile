import 'package:flutter/material.dart';
import 'package:takeout/widgets/home/category_section.dart';
import 'package:takeout/widgets/home/hero_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final chevronDownIcon = 'assets/icons/chevron_down.svg';
    final locationIcon = 'assets/icons/location.svg';
    final notiIcon = 'assets/icons/noti.svg';
    final searchIcon = 'assets/icons/search.svg';
    final bgImg = 'assets/images/home_bg.png';
    final screenHeight = MediaQuery.of(context).size.height;
    final categorySectionTitle = "Find by category";
    final seeBtnLabel = "See all";

    return Scaffold(
      body: Column(
        children: [
          HeroSection(
            screenHeight: screenHeight,
            bgImg: bgImg,
            chevronDownIcon: chevronDownIcon,
            locationIcon: locationIcon,
            searchIcon: searchIcon,
            notiIcon: notiIcon,
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              color: Colors.white,
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    // category section
                    CategorySection(
                      categorySectionTitle: categorySectionTitle,
                      seeBtnLabel: seeBtnLabel,
                    ),
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
