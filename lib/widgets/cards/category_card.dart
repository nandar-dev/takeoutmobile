import 'package:flutter/material.dart';
import 'package:takeout/data/models/category_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/render_custom_image.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.index,
    required this.category,
    required this.onTap,
  });

  final int index;
  final CategoryModel category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 85,
              width: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.neutral30,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: RenderCustomImage(
                      imageUrl: category.image,
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    child: SubText(
                      text:
                          category.name.isEmpty
                              ? "Unavailable name"
                              : category.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      fontSize: FontSizes.sm,
                      textAlign: TextAlign.center,
                      color: AppColors.textSecondary,
                    ),
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
