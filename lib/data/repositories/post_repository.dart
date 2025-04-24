import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:takeout/data/datasource/local/post_local.dart';
import 'package:takeout/data/datasource/remote/post_remote.dart';
import 'package:takeout/data/models/post_model.dart';

class PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;

  PostRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<List<PostModel>> getPosts() async {
    final bool isConnected =
        await InternetConnectionChecker.instance.hasConnection;
    if (isConnected) {
      final remotePosts = await remoteDataSource.fetchPosts();
      await localDataSource.cachePosts(remotePosts);
      return remotePosts;
    } else {
      final localPosts = localDataSource.getCachedPosts();
      if (localPosts.isNotEmpty) {
        return localPosts;
      } else {
        throw Exception('No Internet and no cached data available');
      }
    }
  }
}
