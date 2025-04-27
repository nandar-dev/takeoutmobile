import 'dart:math';

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
}
