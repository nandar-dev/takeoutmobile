import 'package:dio/dio.dart';
import 'package:takeout/api/api_service.dart';
import 'package:takeout/data/models/shoptype_model.dart';

class ShoptypeRemoteDataSource {
  final Dio dio;

  ShoptypeRemoteDataSource(this.dio);

  Future<List<ShoptypeModel>> fetchShopTypes() async {
    final response = await APIService.request(
      '/shoptype',
      DioMethod.get,
    );
    final List<dynamic> data = response.data['data']['shoptypes'];
    return data.map((json) => ShoptypeModel.fromJson(json)).toList();
  }
}