import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:takeout/data/models/post_model.dart';
 
class PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSource(this.client);

  Future<List<PostModel>> fetchPosts() async {
    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> postJson = json.decode(response.body);
      return postJson.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
