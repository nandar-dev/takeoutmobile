import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/category/category_cubit.dart';
import 'package:takeout/cubit/category/category_state.dart';
import 'package:takeout/models/category_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/custom_text_button.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CategoryLoaded) {
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
                  CustomTextButton(
                    btnLabel: widget.seeBtnLabel,
                    onTapCallback:
                        () =>
                            Navigator.pushNamed(context, AppRoutes.categories),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Categories List
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
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
        } else if (state is CategoryError) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text('Press refresh to load.'));
      },
    );
  }
}
