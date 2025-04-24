import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/data/models/post_model.dart';
import 'package:takeout/data/repositories/post_repository.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel> posts;
  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String message;
  PostError(this.message);
}

class PostCubit extends Cubit<PostState> {
  final PostRepository postRepository;
  PostCubit(this.postRepository) : super(PostInitial());

  Future<void> loadPosts() async {
    emit(PostLoading());
    try {
      final posts = await postRepository.getPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError("Failed to fetch posts"));
    }
  }
}
