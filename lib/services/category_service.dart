import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:takeout/models/category_model.dart';

class CategoryService {
  static Future<List<Category>> loadCategories() async {
    final String jsonString = await rootBundle.loadString('assets/data/categories.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((data) => Category.fromJson(data)).toList();
  }
}
