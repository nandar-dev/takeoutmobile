import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:takeout/domain/entities/post.dart';
part 'post_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
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

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  Post toEntity() => Post(userId: userId, id: id, title: title, body: body);

  static PostModel fromEntity(Post post) => PostModel(
    userId: post.userId,
    id: post.id,
    title: post.title,
    body: post.body,
  );
}
