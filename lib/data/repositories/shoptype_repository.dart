import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:takeout/data/datasource/local/shoptype_local.dart';
import 'package:takeout/data/datasource/remote/shoptype_remote.dart';
import 'package:takeout/data/models/shoptype_model.dart';

class ShoptypeRepository {
  final ShoptypeRemoteDataSource remote;
  final ShoptypeLocalDataSource local;
  final InternetConnectionChecker connectionChecker;

  ShoptypeRepository({
    required this.remote,
    required this.local,
    InternetConnectionChecker? connectionChecker,
  }) : connectionChecker =
           connectionChecker ?? InternetConnectionChecker.instance;

  Future<List<ShoptypeModel>> getShoptypes() async {
    try {
      final cachedShoptypes = local.getCachedShoptype();

      final isConnected = await connectionChecker.hasConnection;

      if (isConnected) {
        unawaited(_fetchAndUpdateShoptypesInBackground());
      }

      return cachedShoptypes.isNotEmpty
          ? cachedShoptypes
          : await _fetchShoptypeWithFallback();
    } catch (e) {
      final cachedShoptypes = local.getCachedShoptype();
      if (cachedShoptypes.isNotEmpty) {
        return cachedShoptypes;
      }
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<void> _fetchAndUpdateShoptypesInBackground() async {
    try {
      final freshCategories = await remote.fetchShopTypes();
      await local.cacheShoptype(freshCategories);
    } catch (e) {
      print('Background category update failed: $e');
    }
  }

  Future<List<ShoptypeModel>> _fetchShoptypeWithFallback() async {
    try {
      final isConnected = await connectionChecker.hasConnection;
      if (!isConnected) {
        throw Exception('No internet connection');
      }

      final cachedShoptypes = await remote.fetchShopTypes();
      await local.cacheShoptype(cachedShoptypes);
      return cachedShoptypes;
    } catch (e) {
      // One more attempt to return cached data
      final cachedCategories = local.getCachedShoptype();
      if (cachedCategories.isNotEmpty) {
        return cachedCategories;
      }
      throw Exception('Failed to fetch categories: $e');
    }
  }
}
