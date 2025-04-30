import 'package:dio/dio.dart';
import 'package:takeout/api/api_service.dart';
import 'package:takeout/data/models/category_model.dart';

class CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSource(this.dio);

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await APIService.request(
      '/categories/getall',
      DioMethod.get,
    );
    final List<dynamic> data = response.data['data']['category'];
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }
}