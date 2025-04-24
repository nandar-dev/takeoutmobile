import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeout/models/category_model.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/cards/category_card_2.dart';


class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/categories.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      categories =
          jsonResponse.map((data) => Category.fromJson(data)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = "title.category".tr();

    return Scaffold(
      appBar: AppBarWidget(title: title, borderedBack: false),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: categories.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryCard2(category: category);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}