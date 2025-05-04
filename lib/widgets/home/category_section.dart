import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:takeout/cubit/category/category_cubit.dart';
import 'package:takeout/cubit/category/category_state.dart';
import 'package:takeout/data/models/category_model.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/buttons/custom_text_button.dart';
import 'package:takeout/widgets/cards/category_card.dart';
import 'package:takeout/widgets/toast_widget.dart';
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
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CategoryCubit>();
    if (cubit.state is! CategoryLoaded) {
      cubit.loadCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryError) {
          showToast(message: state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is CategoryLoading;
        final hasError = state is CategoryError;
        final categories = _getCategories(state);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 10),
            _buildCategoryList(isLoading, hasError, categories),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
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
              () => Navigator.pushNamed(context, AppRoutes.categories),
        ),
      ],
    );
  }

  Widget _buildCategoryList(
    bool isLoading,
    bool hasError,
    List<CategoryModel> categories,
  ) {
    return Skeletonizer(
      enabled: isLoading,
      child: SizedBox(
        height: 100,
        child:
            hasError
                ? _buildErrorWidget()
                : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryCard(
                      index: index,
                      isActive: !isLoading && index == _activeIndex,
                      category: category,
                      onTap:
                          () => _handleCategoryTap(isLoading, index, category),
                    );
                  },
                ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Text(
        'Failed to load categories',
        style: TextStyle(color: AppColors.danger),
      ),
    );
  }

  void _handleCategoryTap(bool isLoading, int index, CategoryModel category) {
    if (isLoading) return;

    setState(() => _activeIndex = index);
    Navigator.pushNamed(
      context,
      AppRoutes.products,
      arguments: {'categoryId': category.id},
    );
  }

  List<CategoryModel> _getCategories(CategoryState state) {
    if (state is CategoryLoaded) return state.categories;
    if (state is CategoryError) return [];
    return CategoryLoader().getLoadingCategories(5);
  }
}
