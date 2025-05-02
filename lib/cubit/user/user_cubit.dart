import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/user/user_state.dart';
import 'package:takeout/data/models/user_model.dart';
import 'package:takeout/data/repositories/user_repository.dart';
import 'package:takeout/utils/token_service.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository repository;

  UserCubit(this.repository) : super(UserInitial());

  Future<void> login(String username, String password) async {
    try {
      emit(UserLoading());
      final user = await repository.login(username, password);

      emit(Authenticated(user));
    } on DioException catch (e) {
      final message =
          e.error is String ? e.error : 'Login failed. Please try again.';
      emit(UserError(message.toString()));
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      emit(UserLoading());
      final user = await repository.register(name, email, password);
      emit(Authenticated(user));
    } on DioException catch (e) {
      final message =
          e.error is String
              ? e.error
              : 'Registration failed. Please try again.';
      emit(UserError(message.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(UserLoading());
      await repository.logout();
      emit(Unauthenticated());
    } on DioException catch (e) {
      final message =
          e.error is String
              ? e.error
              : 'An unexpected error occurred during logout.';
      emit(UserError(message.toString()));
    }
    emit(Unauthenticated());
  }

  Future<void> checkAuth() async {
    final token = await TokenStorage.getToken();

    if (token != null && token.isNotEmpty) {
      final user = repository.getLoggedInUser();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> updateProfile(
    String name,
    String email,
    String phone,
    String address,
  ) async {
    try {
      emit(UserLoading());
      final user = await repository.updateProfile(name, email, phone, address);
      emit(Authenticated(user));
    } on DioException catch (e) {
      final message = e.error is String ? e.error : 'Profile update failed.';
      emit(UserError(message.toString()));
    }
  }

  Future<void> updateProfileImage(PlatformFile imageFile) async {
    try {
      emit(UserLoading());
      final user = await repository.updateProfileImage(imageFile);
      emit(Authenticated(user));
    } catch (e) {
      emit(UserError('Image upload failed.'));
    }
  }
}
