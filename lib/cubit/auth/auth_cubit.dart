import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/auth/auth_state.dart';
import 'package:takeout/data/repositories/auth_repository.dart';
import 'package:takeout/utils/token_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    try {
      emit(AuthLoading());
      final user = await repository.login(username, password);

      emit(Authenticated(user));
    } on DioException catch (e) {
      final message =
          e.error is String ? e.error : 'Login failed. Please try again.';
      emit(AuthError(message.toString()));
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await repository.register(name, email, password);
      emit(Authenticated(user));
    } on DioException catch (e) {
      final message =
          e.error is String
              ? e.error
              : 'Registration failed. Please try again.';
      emit(AuthError(message.toString()));
    }
  }

  void logout() {
    repository.logout();
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
}
