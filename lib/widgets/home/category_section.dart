import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeout/models/category_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/cards/category_card.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({
    super.key,
    required this.categorySectionTitle,
    required this.seeBtnLabel,
    required this.href,
  });

  final String categorySectionTitle;
  final String seeBtnLabel;
  final String href;

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
            GestureDetector(
              onTap: () => debugPrint("navigate to ${widget.href}."),
              child: SubText(text: widget.seeBtnLabel, color: AppColors.primary, fontSize: FontSizes.body),
            )
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
