import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';
import 'package:takeout/app.dart';
import 'package:takeout/data/datasource/local/post_local.dart';
import 'package:takeout/data/datasource/remote/auth_remote.dart';
import 'package:takeout/data/datasource/remote/post_remote.dart';
import 'package:takeout/data/models/post_model.dart';
import 'package:takeout/data/repositories/auth_repository.dart';
import 'package:takeout/data/repositories/post_repository.dart';

Future<Widget> initializeApp() async {
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(PostModelAdapter());
  final postBox = await Hive.openBox<PostModel>('postsBox');
  final authBox = await Hive.openBox('authBox');

  // Create repositories
  final postRepository = PostRepository(
    remote: PostRemoteDataSource(Dio()),
    local: PostLocalDataSource(postBox),
  );

  final authRepository = AuthRepository(
    remote: AuthRemoteDataSource(Dio()),
    box: authBox,
  );

  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  return MyApp(authRepository: authRepository, postRepository: postRepository);
}
