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
        ...remoteProducts.where((newItem) =>
          !currentCache.any((cachedItem) => cachedItem.id == newItem.id),
        )
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


// import 'dart:async';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:takeout/data/datasource/local/product_local.dart';
// import 'package:takeout/data/datasource/remote/product_remote.dart';
// import 'package:takeout/data/models/product_model.dart';

// class ProductRepository {
//   final ProductRemoteDataSource remote;
//   final ProductLocalDataSource local;
//   final InternetConnectionChecker connectionChecker;

//   ProductRepository({
//     required this.remote,
//     required this.local,
//     InternetConnectionChecker? connectionChecker,
//   }) : connectionChecker = connectionChecker ?? InternetConnectionChecker.instance;

//   Future<List<ProductModel>> getProducts({
//     int page = 1,
//     int pageSize = 10,
//     bool forceRefresh = false,
//   }) async {
//     try {
//       // Get cached products (paginated)
//       final cachedProducts = _paginateLocalProducts(page, pageSize);

//       // Check internet connection
//       final isConnected = await connectionChecker.hasConnection;

//       if (isConnected) {
//         if (forceRefresh || cachedProducts.isEmpty) {
//           // Force refresh or no cache available - fetch from network
//           return await _fetchProductsWithFallback(page, pageSize);
//         } else {
//           // Return cached data and update in background
//           unawaited(_fetchAndUpdateProductsInBackground(page, pageSize));
//           return cachedProducts;
//         }
//       } else {
//         // Offline - return cached data if available
//         if (cachedProducts.isNotEmpty) {
//           return cachedProducts;
//         }
//         throw Exception('No internet connection and no cached data available');
//       }
//     } catch (e) {
//       // Final fallback to cached data if available
//       final cachedProducts = _paginateLocalProducts(page, pageSize);
//       if (cachedProducts.isNotEmpty) {
//         return cachedProducts;
//       }
//       throw Exception('Failed to load products: $e');
//     }
//   }

//   Future<void> _fetchAndUpdateProductsInBackground(int page, int pageSize) async {
//     try {
//       final freshProducts = await remote.fetchProducts(
//         page: page,
//         perPage: pageSize,
//       );
      
//       // Merge new products with existing cache
//       final currentCache = local.getCachedProduct();
//       final updatedProducts = [
//         ...currentCache,
//         ...freshProducts.where(
//           (newProduct) => !currentCache.any((p) => p.id == newProduct.id),
//         ),
//       ];
      
//       await local.cacheProduct(updatedProducts);
//     } catch (e) {
//       print('Background product update failed: $e');
//     }
//   }

//   Future<List<ProductModel>> _fetchProductsWithFallback(
//     int page,
//     int pageSize,
//   ) async {
//     try {
//       final freshProducts = await remote.fetchProducts(
//         page: page,
//         perPage: pageSize,
//       );
      
//       // Update cache with new products
//       await local.cacheProduct(freshProducts);
//       return freshProducts;
//     } catch (e) {
//       // Try to return cached data if available
//       final cachedProducts = _paginateLocalProducts(page, pageSize);
//       if (cachedProducts.isNotEmpty) {
//         return cachedProducts;
//       }
//       throw Exception('Failed to fetch products: $e');
//     }
//   }

//   List<ProductModel> _paginateLocalProducts(int page, int pageSize) {
//     final allCachedProducts = local.getCachedProduct();
//     if (allCachedProducts.isEmpty) return [];
    
//     final start = (page - 1) * pageSize;
//     final end = start + pageSize;
    
//     return start >= allCachedProducts.length
//         ? []
//         : allCachedProducts.sublist(
//             start,
//             end.clamp(0, allCachedProducts.length),
//           );
//   }
// }