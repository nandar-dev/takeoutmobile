import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:takeout/data/datasource/local/product_local.dart';
import 'package:takeout/data/datasource/remote/product_remote.dart';
import 'package:takeout/data/models/product_model.dart';

class ProductRepository {
  final ProductRemoteDataSource remote;
  final ProductLocalDataSource local;

  ProductRepository({required this.remote, required this.local});

  Future<List<ProductModel>> getProducts({
    required int page,
    required int pageSize,
  }) async {
    final bool isConnected =
        await InternetConnectionChecker.instance.hasConnection;

    if (isConnected) {
      final List<ProductModel> remoteProducts = await remote.fetchProducts(
        page: page,
        perPage: pageSize,
      );

      // Fetch current cache
      final currentCache = local.getCachedProduct();

      // Merge new products into cache
      final updatedCache = [
        ...currentCache,
        ...remoteProducts.where(
          (newItem) =>
              !currentCache.any((cachedItem) => cachedItem.id == newItem.id),
        ),
      ];

      await local.cacheProduct(updatedCache);

      return remoteProducts;
    } else {
      final List<ProductModel> localProducts = local.getCachedProduct();

      if (localProducts.isNotEmpty) {
        final int start = (page - 1) * pageSize;
        final int end = start + pageSize;
        return localProducts.sublist(start, end.clamp(0, localProducts.length));
      } else {
        throw Exception('No Internet and no cached data available');
      }
    }
  }

  Future<List<ProductModel>> getProductsByCategory({
    required int page,
    required int pageSize,
    required String categoryId,
  }) async {
    final bool isConnected =
        await InternetConnectionChecker.instance.hasConnection;

    if (isConnected) {
      final List<ProductModel> remoteProducts = await remote
          .fetchProductsByCategoryId(
            page: page,
            perPage: pageSize,
            categoryId: categoryId,
          );

      // Fetch current cache
      final currentCache = local.getCachedProduct();

      // Merge new products into cache
      final updatedCache = [
        ...currentCache,
        ...remoteProducts.where(
          (newItem) =>
              !currentCache.any((cachedItem) => cachedItem.id == newItem.id),
        ),
      ];

      await local.cacheProduct(updatedCache);

      return remoteProducts;
    } else {
      final List<ProductModel> localProducts = local.getCachedProduct();

      if (localProducts.isNotEmpty) {
        final int start = (page - 1) * pageSize;
        final int end = start + pageSize;
        return localProducts.sublist(start, end.clamp(0, localProducts.length));
      } else {
        throw Exception('No Internet and no cached data available');
      }
    }
  }
}
