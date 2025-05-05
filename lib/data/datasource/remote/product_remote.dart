import 'package:dio/dio.dart';
import 'package:takeout/api/api_service.dart';
import 'package:takeout/data/models/product_model.dart';

class ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSource(this.dio);

  Future<List<ProductModel>> _fetchProductList(
    String endpoint,
    Map<String, dynamic> queryParams,
  ) async {
    final response = await APIService.request(
      endpoint,
      DioMethod.get,
      param: queryParams,
    );
    final List<dynamic> data = response.data['data']['product'];
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<List<ProductModel>> fetchProducts({
    int perPage = 4,
    int page = 1,
  }) async {
    return _fetchProductList('/product', {'per_page': perPage, 'page': page});
  }

  Future<List<ProductModel>> fetchProductsByCategoryId({
    int perPage = 10,
    int page = 1,
    required String categoryId,
  }) async {
    return _fetchProductList('/productbycategory', {
      'category_id': categoryId,
      'per_page': perPage,
      'page': page,
    });
  }
}
