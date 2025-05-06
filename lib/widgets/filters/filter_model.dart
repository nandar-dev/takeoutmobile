import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/bloc/product_filters/bloc.dart';
import 'package:takeout/bloc/product_filters/event.dart';
import 'package:takeout/cubit/category/category_cubit.dart';
import 'package:takeout/cubit/category/category_state.dart';
import 'package:takeout/cubit/product/product_cubit.dart';
import 'package:takeout/cubit/shoptype/shoptype_cubit.dart';
import 'package:takeout/cubit/shoptype/shoptype_state.dart';
import 'package:takeout/data/models/category_model.dart';
import 'package:takeout/data/models/shoptype_model.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/filters/filter_checks_list.dart';
import 'package:takeout/widgets/buttons/outlinebutton_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/product/product_filters.dart';
import 'package:takeout/widgets/toast_widget.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class FilterModal extends StatefulWidget {
  final FilterType filterType;
  final List<int> initialSelectedIds;

  const FilterModal({
    super.key,
    required this.filterType,
    required this.initialSelectedIds,
  });

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  List<ShoptypeModel> shops = [];
  List<String> items = [];
  String title = "";
  late Set<int> selectedItemIds;

  @override
  void initState() {
    super.initState();
    selectedItemIds = Set<int>.from(widget.initialSelectedIds);
    _initData();
  }

  Future<void> _initData() async {
    switch (widget.filterType) {
      case FilterType.category:
        title = "Select Category";
        final categoryCubit = context.read<CategoryCubit>();
        if (categoryCubit.state is! CategoryLoaded) {
          await categoryCubit.loadCategories();
        }
        break;
      case FilterType.shop:
        title = "Filter by Shop";
        final shoptypeCubit = context.read<ShoptypeCubit>();
        if (shoptypeCubit.state is! ShoptypeLoaded) {
          await shoptypeCubit.loadShoptypes();
        }
        break;
      case FilterType.sort:
        items = ['Price: Low to High', 'Price: High to Low', 'Popularity'];
        title = "Sort";
        break;
      case FilterType.offer:
        items = ['Special Offers', 'Discounts', 'Bundle Deals'];
        title = "Offer";
        break;
    }
  }

  void toggleSelection(int id) {
    setState(() {
      if (selectedItemIds.contains(id)) {
        selectedItemIds.remove(id);
      } else {
        selectedItemIds.add(id);
      }
    });
  }

  void _applyFilters() {
    context.read<FilterBloc>().add(
      FilterSelectionChanged(
        filterType: widget.filterType,
        selectedIds: selectedItemIds.toList(),
      ),
    );

    if (widget.filterType == FilterType.category) {
      final categoryIds = selectedItemIds.join(',');
      if (categoryIds.isNotEmpty) {
        context.read<ProductCubit>().loadProductsByCategory(
          pageSize: 10,
          categoryId: categoryIds,
        );
      } else {
        context.read<ProductCubit>().loadProducts(pageSize: 10);
      }
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is CategoryError) {
              showToast(message: state.message);
            }
          },
        ),
        BlocListener<ShoptypeCubit, ShoptypeState>(
          listener: (context, state) {
            if (state is ShoptypeError) {
              showToast(message: state.message);
            }
          },
        ),
      ],
      child: Container(
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
          top: 12,
          bottom: 18,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: title,
              color: AppColors.textPrimary,
              fontSize: FontSizes.heading2,
            ),
            const SizedBox(height: 8),

            // Dynamic checkbox list rendering
            if (widget.filterType == FilterType.category)
              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  final categories = _getCategories(state);
                  return FilterChecksList<CategoryModel>(
                    data: categories,
                    selectedItemIds: selectedItemIds,
                    idGetter: (cat) => cat.id,
                    labelGetter: (cat) => cat.name,
                    onToggle: toggleSelection,
                  );
                },
              )
            else if (widget.filterType == FilterType.shop)
              BlocBuilder<ShoptypeCubit, ShoptypeState>(
                builder: (context, state) {
                  final shoptypes = _getShoptypes(state);
                  final isLoading = state is ShoptypeLoading;
                  return FilterChecksList<ShoptypeModel>(
                    data: shoptypes,
                    selectedItemIds: selectedItemIds,
                    idGetter: (shop) => shop.id,
                    labelGetter: (shop) => shop.name,
                    onToggle: toggleSelection,
                    isLoading: isLoading,
                  );
                },
              )
            else
              FilterChecksList<String>(
                data: items,
                selectedItemIds: selectedItemIds,
                idGetter: (item) => items.indexOf(item),
                labelGetter: (item) => item,
                onToggle: toggleSelection,
              ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    text: "Reset",
                    onPressed: () {
                      setState(() {
                        selectedItemIds.clear();
                      });
                      _applyFilters();
                    },
                    borderColor: AppColors.neutral40,
                    borderRadius: 10,
                    fontSize: FontSizes.md,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomPrimaryButton(
                    text: "Apply",
                    onPressed: _applyFilters,
                    borderRadius: 10,
                    fontSize: FontSizes.md,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<CategoryModel> _getCategories(CategoryState state) {
    if (state is CategoryLoaded) {
      return state.categories;
    }
    return [];
  }

  List<ShoptypeModel> _getShoptypes(ShoptypeState state) {
    if (state is ShoptypeLoaded) return state.shoptypes;
    if (state is ShoptypeError) return [];
    return ShoptypeLoader().getLoadingShoptypes(5);
  }
}
