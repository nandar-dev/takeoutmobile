import 'package:takeout/data/models/shoptype_model.dart';

abstract class ShoptypeState {}

class ShoptypeInitial extends ShoptypeState {}

class ShoptypeLoading extends ShoptypeState {}

class ShoptypeLoaded extends ShoptypeState {
  final List<ShoptypeModel> shoptypes;
  ShoptypeLoaded(this.shoptypes);
}

class ShoptypeError extends ShoptypeState {
  final String message;
  ShoptypeError(this.message);
}
