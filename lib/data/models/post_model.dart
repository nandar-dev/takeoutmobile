import 'package:hive_flutter/hive_flutter.dart';
import 'package:takeout/domain/entities/post.dart';

part 'post_model.g.dart';

@HiveType(typeId: 0)
class PostModel extends HiveObject {
  @HiveField(0)
  final int? userId;

  @HiveField(1)
  final int? id;

  @HiveField(2)
  final String? title;

  @HiveField(3)
  final String? body;

  PostModel({this.userId, this.id, this.title, this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    userId: json['userId'],
    id: json['id'],
    title: json['title'],
    body: json['body'],
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
    'body': body,
  };
  Post toEntity() => Post(userId: userId, id: id, title: title, body: body);

  static PostModel fromEntity(Post post) => PostModel(
    userId: post.userId,
    id: post.id,
    title: post.title,
    body: post.body,
  );
}
