import 'package:flutter/material.dart';
import 'package:takeout/models/category_model.dart' show Category;
import 'package:takeout/models/shop_model.dart';
import 'package:takeout/services/category_service.dart';
import 'package:takeout/services/shop_service.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:takeout/utils/font_sizes.dart';
import 'package:takeout/widgets/filters/filter_checks_list.dart';
import 'package:takeout/widgets/buttons/outlinebutton_widget.dart';
import 'package:takeout/widgets/buttons/primarybutton_widget.dart';
import 'package:takeout/widgets/product/product_filters.dart';
import 'package:takeout/widgets/typography_widgets.dart';

class FilterModal extends StatefulWidget {
  final FilterType filterType;

  const FilterModal({super.key, required this.filterType});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  List<Category> categories = [];
  List<Shop> shops = [];
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
    switch (widget.filterType) {
      case FilterType.category:
        categories = await CategoryService.loadCategories();
        title = "Select Category";
        break;
      case FilterType.shop:
        shops = await ShopService.loadShops();
        title = "Filter by Shop";
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

    setState(() {
      isLoading = false;
    });
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
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      padding: const EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 18),
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
            FilterChecksList<Category>(
              data: categories,
              selectedItemIds: selectedItemIds,
              idGetter: (cat) => cat.id,
              labelGetter: (cat) => cat.name,
              onToggle: toggleSelection,
            )
          else if (widget.filterType == FilterType.shop)
            FilterChecksList<Shop>(
              data: shops,
              selectedItemIds: selectedItemIds,
              idGetter: (shop) => shop.id,
              labelGetter: (shop) => shop.name,
              onToggle: toggleSelection,
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
                  fontSize: FontSizes.body1,
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
                  fontSize: FontSizes.body1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}