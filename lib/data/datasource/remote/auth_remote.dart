import 'package:dio/dio.dart';
import 'package:takeout/data/models/user_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<UserModel> login(String email, String password) async {
    final response = await dio.post(
      'https://yourapi.com/login',
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data);
  }
}
