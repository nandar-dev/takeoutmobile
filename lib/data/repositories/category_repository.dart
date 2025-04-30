import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:takeout/data/datasource/local/category_local.dart';
import 'package:takeout/data/datasource/remote/category_remote.dart';
import 'package:takeout/data/models/category_model.dart';

class CategoryRepository {
  final CategoryRemoteDataSource remote;
  final CategoryLocalDataSource local;

  CategoryRepository({required this.remote, required this.local});

  Future<List<CategoryModel>> getCategories() async {
    final bool isConnected =
        await InternetConnectionChecker.instance.hasConnection;
    if (isConnected) {
      final remoteCategoris = await remote.fetchCategories();
      await local.cacheCategory(remoteCategoris);
      return remoteCategoris;
    } else {
      final localCategoris = local.getCachedCategory();
      if (localCategoris.isNotEmpty) {
        return localCategoris;
      } else {
        throw Exception('No Internet and no cached data available');
      }
    }
  }
}
