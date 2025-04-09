import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/iconbutton_one_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.screenHeight,
    required this.bgImg,
    required this.chevronDownIcon,
    required this.locationIcon,
    required this.searchIcon,
    required this.notiIcon,
  });

  final double screenHeight;
  final String bgImg;
  final String chevronDownIcon;
  final String locationIcon;
  final String searchIcon;
  final String notiIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(bgImg),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SubText(text: "Your Location", color: AppColors.textLight),
                    SizedBox(width: 10),
                    SvgPicture.asset(chevronDownIcon, height: 8, width: 8),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    SvgPicture.asset(locationIcon, height: 18, width: 18),
                    SizedBox(width: 10),
                    SubText(text: "Yangon", color: AppColors.textLight),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                IconButtonOneWidget(
                  icon: searchIcon,
                  onTap: () {
                    debugPrint("search button clicked");
                  },
                ),
                SizedBox(width: 15),
                IconButtonOneWidget(
                  icon: notiIcon,
                  onTap: () {
                    debugPrint("noti button clicked");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
