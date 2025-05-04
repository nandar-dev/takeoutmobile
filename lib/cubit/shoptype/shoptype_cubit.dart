import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/shoptype/shoptype_state.dart';
import 'package:takeout/data/models/shoptype_model.dart';
import 'package:takeout/data/repositories/shoptype_repository.dart';

class ShoptypeCubit extends Cubit<ShoptypeState> {
  final ShoptypeRepository repository;
  StreamSubscription? _categoriesSubscription;

  ShoptypeCubit(this.repository) : super(ShoptypeInitial()) {
    // Load initial data when cubit is created
    loadShoptypes();
  }

  @override
  Future<void> close() {
    _categoriesSubscription?.cancel();
    return super.close();
  }

  Future<void> loadShoptypes() async {
    try {
      final cachedShoptypes = repository.local.getCachedShoptype();

      if (cachedShoptypes.isNotEmpty) {
        emit(ShoptypeLoaded(cachedShoptypes.cast<ShoptypeModel>()));
      } else {
        emit(ShoptypeLoading());
      }
      _fetchFreshShoptypes();
    } catch (e) {
      emit(ShoptypeError(e.toString()));
    }
  }

  Future<void> _fetchFreshShoptypes() async {
    try {
      final categories = await repository.getShoptypes();
      if (!isClosed) {
        emit(ShoptypeLoaded(categories.cast<ShoptypeModel>()));
      }
    } catch (e) {
      if (state is! ShoptypeLoaded && !isClosed) {
        emit(ShoptypeError(e.toString()));
      }
    }
  }
}
