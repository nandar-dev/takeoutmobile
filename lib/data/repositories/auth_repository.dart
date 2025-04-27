import 'package:hive_flutter/hive_flutter.dart';
import 'package:takeout/data/datasource/remote/auth_remote.dart';
import 'package:takeout/data/models/user_model.dart';
import 'package:takeout/utils/token_service.dart';

class AuthRepository {
  final AuthRemoteDataSource remote;
  final Box box;

  AuthRepository({required this.remote, required this.box});

  Future<UserModel> login(String email, String password) async {
    final userModel = await remote.login(email, password);
    await box.put('user', userModel);
    return userModel;
  }

  UserModel? getLoggedInUser() {
    final UserModel? userModel = box.get('user');
    return userModel;
  }

  Future<void> logout() async {
    TokenStorage.deleteToken();
    await box.delete('user');
  }
}
