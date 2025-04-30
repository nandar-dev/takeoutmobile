import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/category/category_state.dart';
import 'package:takeout/data/models/category_model.dart';
import 'package:takeout/data/repositories/category_repository.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository repository;

  CategoryCubit(this.repository) : super(CategoryInitial());

  Future<void> loadCategories() async {
    try {
      emit(CategoryLoading());
      final categories = await repository.getCategories();
      emit(CategoryLoaded(categories.cast<CategoryModel>()));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
