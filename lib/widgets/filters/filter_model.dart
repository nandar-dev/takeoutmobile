import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/category/category_cubit.dart';
import 'package:takeout/cubit/category/category_state.dart';
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

  const FilterModal({super.key, required this.filterType});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  List<ShoptypeModel> shops = []; //changed to shoptypemodel
  List<String> items = [];
  String title = "";
  final Set<int> selectedItemIds = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    setState(() {
      isLoading = true;
    });
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
        items = ['testing1', 'testing2'];
        title = "Sort";
        break;
      case FilterType.offer:
        items = ['testing1', 'testing2'];
        title = "Offer";
        break;
    }
    if (mounted) {
      //check the widget is mounted or not
      setState(() {
        isLoading = false; // End loading
      });
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
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
          top: 12,
          bottom: 18,
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
            //show loading
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
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
                //build based on ShoptypeCubit
                builder: (context, state) {
                  final shoptypes = _getShoptypes(state);
                  return FilterChecksList<ShoptypeModel>(
                    data: shoptypes,
                    selectedItemIds: selectedItemIds,
                    idGetter: (shop) => shop.id,
                    labelGetter: (shop) => shop.name,
                    onToggle: toggleSelection,
                  );
                },
              )
            else
              FilterChecksList<String>(
                data: items,
                selectedItemIds: selectedItemIds,
                idGetter: (item) => item.hashCode,
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
                    onPressed: () {
                      Navigator.pop(context, selectedItemIds.toList());
                    },
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
    if (state is ShoptypeLoaded) {
      return state.shoptypes;
    }
    return [];
  }
}
