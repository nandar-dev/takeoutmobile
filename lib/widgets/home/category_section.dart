import 'package:flutter/material.dart';
import 'package:takeout/models/category_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/services/category_service.dart'; // Import the service
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/cards/category_card.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({
    super.key,
    required this.categorySectionTitle,
    required this.seeBtnLabel,
  });

  final String categorySectionTitle;
  final String seeBtnLabel;

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  List<Category> categories = [];
  int activeIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    categories = await CategoryService.loadCategories();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubText(
              text: widget.categorySectionTitle,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: FontSizes.md,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.categories),
              child: SubText(
                text: widget.seeBtnLabel,
                color: AppColors.primary,
                fontSize: FontSizes.body,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Categories List
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryCard(
                    index: index,
                    isActive: index == activeIndex,
                    category: category,
                    onTap: () {
                      setState(() {
                        activeIndex = index;
                        Navigator.pushNamed(
                          context,
                          AppRoutes.products,
                          arguments: {'categoryId': category.id},
                        );
                      });
                    },
                  );
                },
              ),
            ),
      ],
    );
  }
}
