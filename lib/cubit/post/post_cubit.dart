import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/post/post_state.dart';
import 'package:takeout/data/repositories/post_repository.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository repository;

  PostCubit(this.repository) : super(PostInitial());

  Future<void> loadPosts() async {
    try {
      emit(PostLoading());
      final posts = await repository.getPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}