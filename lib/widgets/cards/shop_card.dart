import 'package:flutter/material.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/render_network_image.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class ShopCard extends StatelessWidget {
  const ShopCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.status,
    required this.onTap,
  });

  final String status;
  final String imageUrl;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0.1,
        color: AppColors.background,
        borderOnForeground: false,
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: RenderNetworkImage(
                imageUrl: imageUrl,
                height: 100,
                width: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8),
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
                  SizedBox(width: 5),
                  SubText(
                    text: status,
                    color: AppColors.textSecondary,
                    fontSize: FontSizes.body,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
