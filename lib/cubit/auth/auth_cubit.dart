import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/auth/auth_state.dart';
import 'package:takeout/data/repositories/auth_repository.dart';

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

  void logout() {
    repository.logout();
    emit(Unauthenticated());
  }

  // Future<void> checkAuth() async {
  //   final token = await repository.getToken();
  //   if (token != null && token.isNotEmpty) {
  //     emit(Authenticated(token));
  //   } else {
  //     emit(Unauthenticated());
  //   }
  // }
}
