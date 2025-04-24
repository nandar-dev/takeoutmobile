import 'package:dio/dio.dart';
import 'package:takeout/data/models/post_model.dart';

class PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSource(this.dio);

  Future<List<PostModel>> fetchPosts() async {
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/posts',
    );
    final List<dynamic> data = response.data;
    return data.map((json) => PostModel.fromJson(json)).toList();
  }
}
