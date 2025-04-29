import 'package:takeout/data/models/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class Authenticated extends UserState {
  final UserModel user;
  Authenticated(this.user);
}

class Unauthenticated extends UserState {}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
