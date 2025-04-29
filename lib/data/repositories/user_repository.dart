import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:takeout/data/datasource/remote/user_remote.dart';
import 'package:takeout/data/models/user_model.dart';
import 'package:takeout/utils/token_service.dart';

class UserRepository {
  final UserRemoteDataSource remote;
  final Box box;

  UserRepository({required this.remote, required this.box});

  Future<UserModel> login(String email, String password) async {
    final userModel = await remote.login(email, password);
    await box.put('user', userModel);
    return userModel;
  }

  Future<UserModel> register(String name, String email, String password) async {
    final userModel = await remote.register(name, email, password);
    await box.put('user', userModel);
    return userModel;
  }

  UserModel? getLoggedInUser() {
    final UserModel? userModel = box.get('user');
    return userModel;
  }

  Future<void> logout() async {
    await remote.logout();
    TokenStorage.deleteToken();
    await box.delete('user');
  }

  Future<UserModel> updateProfile(
    String name,
    String email,
    String phone,
    String address,
  ) async {
    final userModel = await remote.updateProfile(name, email, phone, address);
    await box.put('user', userModel);
    return userModel;
  }

    Future<UserModel> updateProfileImage(PlatformFile imageFile) async {
    final userModel = await remote.updateProfileImage(imageFile);
    await box.put('user', userModel);
    return userModel;
  }
}
