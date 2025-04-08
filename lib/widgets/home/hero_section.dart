import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:takeout/theme/app_colors.dart';

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
                    Text(
                      "Your Location",
                      style: TextStyle(
                        color: AppColors.textLight,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 10),
                    SvgPicture.asset(
                      chevronDownIcon,
                      height: 8,
                      width: 8,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    SvgPicture.asset(
                      locationIcon,
                      height: 18,
                      width: 18,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Yangon",
                      style: TextStyle(
                        color: AppColors.textLight,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.textLight,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      searchIcon,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.textLight,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      notiIcon,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
