import 'package:hive/hive.dart';
import 'package:takeout/data/models/post_model.dart';

class PostLocalDataSource {
  final Box<PostModel> box;

  PostLocalDataSource(this.box);

  Future<void> cachePosts(List<PostModel> posts) async {
    await box.clear();
    for (var post in posts) {
      await box.add(post);
    }
  }

  List<PostModel> getCachedPosts() {
    return box.values.toList();
  }
}
