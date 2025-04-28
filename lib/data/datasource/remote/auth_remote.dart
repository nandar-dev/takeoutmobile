import 'package:dio/dio.dart';
import 'package:takeout/api/api_service.dart';
import 'package:takeout/data/models/user_model.dart';
import 'package:takeout/utils/token_service.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<UserModel> login(String email, String password) async {
    final response = await APIService.request(
      '/user/login',
      DioMethod.post,
      data: {'email': email, 'password': password},
    );
    final data = response.data;
    final token = data['data']['token'];
    await TokenStorage.saveToken(token);
    return UserModel.fromJson(data);
  }

  Future<UserModel> register(String name, String email, String password) async {
    final response = await APIService.request(
      '/user/register',
      DioMethod.post,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': password,
      },
    );
    final data = response.data;
    return UserModel.fromJson(data);
  }
}
