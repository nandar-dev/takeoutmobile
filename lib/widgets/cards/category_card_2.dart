import 'package:flutter/material.dart';
import 'package:takeout/data/models/category_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/render_custom_image.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class CategoryCard2 extends StatelessWidget {
  const CategoryCard2({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.primary.withValues(alpha: .2),
      onTap: () {
        // Handle tap if needed
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.neutral30,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: RenderCustomImage(
                  imageUrl: category.image ?? "",
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SubText(
                text: category.name ?? "",
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: FontSizes.md,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
