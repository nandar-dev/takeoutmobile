import 'package:flutter/material.dart';
import 'package:takeout/models/category_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/render_network_image.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.index,
    required this.isActive,
    required this.category,
    required this.onTap,
  });

  final int index;
  final bool isActive;
  final Category category;
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
              height: 75,
              width: 70,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : null,
                border: Border.all(
                  color: isActive ? AppColors.primary : AppColors.neutral30,
                  width: isActive ? 0 : 1,
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
                    child: RenderNetworkImage(imageUrl: category.imageUrl, height: 20, width: 20,)
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          isActive
                              ? AppColors.textLight
                              : AppColors.textSecondary,
                    ),
                    child: Text(
                      category.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
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
