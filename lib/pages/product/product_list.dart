import 'package:flutter/material.dart';
import 'package:takeout/widgets/appbar_sidget_2.dart';
import 'package:takeout/widgets/sort_button.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, this.categoryId});

  final int? categoryId;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final String title = "Products List";
  final String sortBtnLabel = "Sort";
  final String sortBtnIcon = "assets/icons/chevron_down.svg";
  final String filterBtnIcon = "assets/icons/filter.svg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget2(title: title),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SortButton(
                  onTap: () {
                    
                  },
                  icon: filterBtnIcon,
                ),
                SortButton(
                  onTap: () {
                    
                  },
                  label: sortBtnLabel,
                  icon: sortBtnIcon,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
