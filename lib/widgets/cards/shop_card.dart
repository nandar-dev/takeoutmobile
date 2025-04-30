import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/render_custom_image.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ShopCard extends StatelessWidget {
  const ShopCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.status,
    required this.onTap,
    this.showStatus = true,
    this.width = 140,
    this.imageHeight = 100,
  });

  final String status;
  final String imageUrl;
  final String name;
  final VoidCallback onTap;
  final bool? showStatus;
  final double width;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        child: Card(
          elevation: 0.5,
          color: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: RenderCustomImage(
                    imageUrl: imageUrl,
                    width: width,
                    height: imageHeight,
                    rounded: 0,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SubText(
                  text: name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),
              if (showStatus == true)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: status == "Open" ? AppColors.success : AppColors.danger,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SubText(
                        text: "home.${status.toLowerCase()}".tr(),
                        color: AppColors.textSecondary,
                        fontSize: FontSizes.body,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}