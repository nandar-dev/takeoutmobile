import 'package:hive_flutter/hive_flutter.dart';
import 'package:takeout/data/datasource/remote/auth_remote.dart';
import 'package:takeout/domain/entities/user.dart';
import 'package:takeout/data/models/user_model.dart';

class AuthRepository {
  final AuthRemoteDataSource remote;
  final Box box;

  AuthRepository({required this.remote, required this.box});

  Future<User> login(String email, String password) async {
    final userModel = await remote.login(email, password);
    await box.put('user', userModel);
    return userModel.toEntity();
  }

  User? getLoggedInUser() {
    final UserModel? userModel = box.get('user');
    return userModel?.toEntity();
  }

  Future<void> logout() async {
    await box.delete('user');
  }
}
