import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:takeout/cubit/category/category_cubit.dart';
import 'package:takeout/cubit/category/category_state.dart';
import 'package:takeout/data/models/category_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/cards/category_card_2.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
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
    final title = "title.category".tr();

    return Scaffold(
      appBar: AppBarWidget(title: title, borderedBack: false),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          final isLoading = state is CategoryLoading;
          final hasError = state is CategoryError;
          final categories = _getCategories(state);

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [_buildCategoryList(isLoading, hasError, categories)],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryList(
    bool isLoading,
    bool hasError,
    List<CategoryModel> categories,
  ) {
    return Skeletonizer(
      enabled: isLoading,
      child:
          hasError
              ? _buildErrorWidget()
              : Expanded(
                child: ListView.separated(
                  itemCount: categories.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryCard2(category: category);
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

  List<CategoryModel> _getCategories(CategoryState state) {
    if (state is CategoryLoaded) return state.categories;
    if (state is CategoryError) return [];
    return CategoryLoader().getLoadingCategories(5);
  }
}
