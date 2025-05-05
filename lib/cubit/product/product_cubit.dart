import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/product/product_state.dart';
import 'package:takeout/data/models/product_model.dart';
import 'package:takeout/data/repositories/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  List<ProductModel> _allProducts = [];
  int _currentPage = 1;
  int _pageSize = 4;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  ProductCubit(this.repository) : super(ProductInitial());

  Future<void> loadProducts({
    bool isLoadMore = false,
    required int pageSize,
  }) async {
    // Prevent duplicate calls
    if (_isLoadingMore || (!_hasMore && isLoadMore)) return;

    try {
      _pageSize = pageSize;

      if (!isLoadMore) {
        // Initial load
        emit(ProductLoading());
        _currentPage = 1;
        _allProducts.clear();
        _hasMore = true;
      } else {
        // Loading more
        emit(ProductLoadingMore(List<ProductModel>.from(_allProducts)));
        _isLoadingMore = true;
        _currentPage++;
      }

      final products = await repository.getProducts(
        page: _currentPage,
        pageSize: _pageSize,
      );

      // Update hasMore based on response
      _hasMore = products.length >= _pageSize;

      // Update products list
      if (isLoadMore) {
        _allProducts.addAll(products);
      } else {
        _allProducts = products;
      }

      emit(ProductLoaded(_allProducts));
    } catch (e) {
      emit(ProductError(e.toString()));
      // On error, revert page increment if loading more
      if (isLoadMore) _currentPage--;
    } finally {
      _isLoadingMore = false;
    }
  }

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> loadProductsByCategory({
    bool isLoadMore = false,
    required int pageSize,
    required String categoryId,
  }) async {
    // Prevent duplicate calls
    if (_isLoadingMore || (!_hasMore && isLoadMore)) return;

    try {
      _pageSize = pageSize;

      if (!isLoadMore) {
        // Initial load
        emit(ProductLoading());
        _currentPage = 1;
        _allProducts.clear();
        _hasMore = true;
      } else {
        // Loading more
        emit(ProductLoadingMore(List<ProductModel>.from(_allProducts)));
        _isLoadingMore = true;
        _currentPage++;
      }

      final products = await repository.getProductsByCategory(
        page: _currentPage,
        pageSize: _pageSize,
        categoryId: categoryId,
      );

      // Update hasMore based on response
      _hasMore = products.length >= _pageSize;

      // Update products list
      if (isLoadMore) {
        _allProducts.addAll(products);
      } else {
        _allProducts = products;
      }

      emit(ProductLoaded(_allProducts));
    } catch (e) {
      emit(ProductError(e.toString()));
      // On error, revert page increment if loading more
      if (isLoadMore) _currentPage--;
    } finally {
      _isLoadingMore = false;
    }
  }
}
