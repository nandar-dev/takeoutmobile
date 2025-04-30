import 'package:hive_flutter/hive_flutter.dart';
import 'package:takeout/data/models/category_model.dart';

class CategoryLocalDataSource {
  final Box<CategoryModel> box;

  CategoryLocalDataSource(this.box);

  Future<void> cacheCategory(List<CategoryModel> categories) async {
    await box.clear();
    for (var category in categories) {
      await box.add(category);
    }
  }

  List<CategoryModel> getCachedCategory() {
    return box.values.toList();
  }
}
