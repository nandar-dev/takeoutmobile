// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:takeout/data/datasource/local/post_local.dart';
// import 'package:takeout/data/datasource/remote/post_remote.dart';
// import 'package:takeout/domain/entities/post.dart';

// class PostRepository {
//   final PostRemoteDataSource remote;
//   final PostLocalDataSource local;

//   PostRepository({
//     required this.remote, required this.local,
//   });

//   Future<List<Post>> getPosts() async {
//     final isConnected = await InternetConnectionChecker.instance.hasConnection;

//     if (isConnected) {
//       final remotePosts = await remote.fetchPosts();
//       await local.cachePosts(remotePosts);
//       return remotePosts.map((e) => e.toEntity()).toList();
//     } else {
//       final localPosts = local.getCachedPosts();
//       if (localPosts.isNotEmpty) {
//         return localPosts.map((e) => e.toEntity()).toList();
//       } else {
//         throw Exception('No Internet and no cached posts available');
//       }
//     }
//   }
// }

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:takeout/data/datasource/local/post_local.dart';
import 'package:takeout/data/datasource/remote/post_remote.dart';
import 'package:takeout/data/models/post_model.dart';

class PostRepository {
  final PostRemoteDataSource remote;
  final PostLocalDataSource local;

  PostRepository({required this.remote, required this.local});

  Future<List<PostModel>> getPosts() async {
    final bool isConnected =
        await InternetConnectionChecker.instance.hasConnection;
    // if (isConnected) {
      final remotePosts = await remote.fetchPosts();
      await local.cachePosts(remotePosts);
      return remotePosts;
    // } else {
    //   final localPosts = local.getCachedPosts();
    //   if (localPosts.isNotEmpty) {
    //     return localPosts;
    //   } else {
    //     throw Exception('No Internet and no cached data available');
    //   }
    // }
  }
}
