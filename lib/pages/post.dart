import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/cubit/post/post_cubit.dart';
import 'package:takeout/cubit/post/post_state.dart';


class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (_, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(post.title ?? ''),
                  subtitle: Text(post.body ?? ''),
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Press refresh to load posts.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<PostCubit>().loadPosts(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
