import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/category/category_state.dart';
import 'package:takeout/data/models/category_model.dart';
import 'package:takeout/data/repositories/category_repository.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository repository;
  StreamSubscription? _categoriesSubscription;

  CategoryCubit(this.repository) : super(CategoryInitial()) {
    // Load initial data when cubit is created
    loadCategories();
  }

  @override
  Future<void> close() {
    _categoriesSubscription?.cancel();
    return super.close();
  }

  Future<void> loadCategories() async {
    try {
      final cachedCategories = repository.local.getCachedCategory();

      if (cachedCategories.isNotEmpty) {
        emit(CategoryLoaded(cachedCategories.cast<CategoryModel>()));
      } else {
        emit(CategoryLoading());
      }
      _fetchFreshCategories();
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> _fetchFreshCategories() async {
    try {
      final categories = await repository.getCategories();
      if (!isClosed) {
        emit(CategoryLoaded(categories.cast<CategoryModel>()));
      }
    } catch (e) {
      if (state is! CategoryLoaded && !isClosed) {
        emit(CategoryError(e.toString()));
      }
    }
  }
}
