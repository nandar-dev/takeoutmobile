import 'package:dio/dio.dart';
import 'package:takeout/api/api_service.dart';
import 'package:takeout/data/models/product_model.dart';

class ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSource(this.dio);

  Future<List<ProductModel>> fetchProducts({
    int perPage = 4,
    int page = 1,
  }) async {
    final response = await APIService.request(
      '/product?per_page=$perPage&page=$page',
      DioMethod.get,
    );
    final List<dynamic> data = response.data['data']['product'];

    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}
