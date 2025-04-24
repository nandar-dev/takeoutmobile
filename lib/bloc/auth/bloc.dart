import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/bloc/auth/event.dart';
import 'package:takeout/bloc/auth/state.dart';
import 'package:takeout/data/repositories/auth_repository.dart';
 

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepo.login(event.email, event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
