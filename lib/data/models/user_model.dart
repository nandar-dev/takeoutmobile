import 'package:hive_flutter/hive_flutter.dart';
import 'package:takeout/domain/entities/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String token;

  @HiveField(1)
  final String name;

  UserModel({required this.token, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'],
      name: json['name'],
    );
  }

  User toEntity() => User(token: token, name: name);
}
