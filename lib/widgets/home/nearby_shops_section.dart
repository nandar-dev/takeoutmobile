import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  onTap: () {
                    debugPrint("chevron left button clicked");
                  },
                ),
                SizedBox(width: 8,),
                IconButtonTwoWidget(
                  icon: widget.chevronRightIcon,
                  onTap: () {
                    debugPrint("chevron right button clicked");
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
