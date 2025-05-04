import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:takeout/data/datasource/local/category_local.dart';
import 'package:takeout/data/datasource/remote/category_remote.dart';
import 'package:takeout/data/models/category_model.dart';

class CategoryRepository {
  final CategoryRemoteDataSource remote;
  final CategoryLocalDataSource local;
  final InternetConnectionChecker connectionChecker;

  CategoryRepository({
    required this.remote,
    required this.local,
    InternetConnectionChecker? connectionChecker,
  }) : connectionChecker =
           connectionChecker ?? InternetConnectionChecker.instance;

  Future<List<CategoryModel>> getCategories() async {
    try {
      final cachedCategories = local.getCachedCategory();

      final isConnected = await connectionChecker.hasConnection;

      if (isConnected) {
        unawaited(_fetchAndUpdateCategoriesInBackground());
      }

      return cachedCategories.isNotEmpty
          ? cachedCategories
          : await _fetchCategoriesWithFallback();
    } catch (e) {
      final cachedCategories = local.getCachedCategory();
      if (cachedCategories.isNotEmpty) {
        return cachedCategories;
      }
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<void> _fetchAndUpdateCategoriesInBackground() async {
    try {
      final freshCategories = await remote.fetchCategories();
      await local.cacheCategory(freshCategories);
    } catch (e) {
      print('Background category update failed: $e');
    }
  }

  Future<List<CategoryModel>> _fetchCategoriesWithFallback() async {
    try {
      final isConnected = await connectionChecker.hasConnection;
      if (!isConnected) {
        throw Exception('No internet connection');
      }

      final freshCategories = await remote.fetchCategories();
      await local.cacheCategory(freshCategories);
      return freshCategories;
    } catch (e) {
      // One more attempt to return cached data
      final cachedCategories = local.getCachedCategory();
      if (cachedCategories.isNotEmpty) {
        return cachedCategories;
      }
      throw Exception('Failed to fetch categories: $e');
    }
  }
}
