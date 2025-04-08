import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeout/models/category_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
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

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/categories.json',
    );
    final List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      categories = jsonResponse.map((data) => Category.fromJson(data)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubText(
              text: widget.categorySectionTitle,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: FontSizes.body1,
            ),
            SubText(text: widget.seeBtnLabel, color: AppColors.primary),
          ],
        ),
        const SizedBox(height: 10),
        // Categories List
        categories.isEmpty
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
                  color: isActive ? AppColors.primary : AppColors.neutral40,
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(category.imageUrl, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize: 12,
                      color: isActive
                          ? AppColors.textLight
                          : AppColors.textSecondary,
                    ),
                    child: Text(
                      category.name,
                      maxLines: 2, // Allow a maximum of 2 lines
                      overflow: TextOverflow.ellipsis, // Handle overflow
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