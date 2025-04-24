import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/bloc/post/event.dart';
import 'package:takeout/bloc/post/state.dart';
import 'package:takeout/data/repositories/post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await repository.getPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}
