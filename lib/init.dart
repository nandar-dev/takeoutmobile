import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';
import 'package:takeout/app.dart';
import 'package:takeout/data/datasource/local/category_local.dart';
import 'package:takeout/data/datasource/local/post_local.dart';
import 'package:takeout/data/datasource/remote/category_remote.dart';
import 'package:takeout/data/datasource/remote/user_remote.dart';
import 'package:takeout/data/datasource/remote/post_remote.dart';
import 'package:takeout/data/models/category_model.dart';
import 'package:takeout/data/models/post_model.dart';
import 'package:takeout/data/models/user_model.dart';
import 'package:takeout/data/repositories/category_repository.dart';
import 'package:takeout/data/repositories/user_repository.dart';
import 'package:takeout/data/repositories/post_repository.dart';

Future<Widget> initializeApp() async {
  // Initialize Hive
  await Hive.initFlutter();

  // await Hive.deleteBoxFromDisk('authBox');
  // await Hive.deleteBoxFromDisk('user');

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(PostModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  final authBox = await Hive.openBox<UserModel>('authBox');
  final postBox = await Hive.openBox<PostModel>('postsBox');
  final categoryBox = await Hive.openBox<CategoryModel>('categoryBox');

  // Create repositories
  final userRepository = UserRepository(
    remote: UserRemoteDataSource(Dio()),
    box: authBox,
  );
  final postRepository = PostRepository(
    remote: PostRemoteDataSource(Dio()),
    local: PostLocalDataSource(postBox),
  );

  final categoryRepository = CategoryRepository(
    remote: CategoryRemoteDataSource(Dio()),
    local: CategoryLocalDataSource(categoryBox),
  );

  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  return MyApp(
    userRepository: userRepository,
    postRepository: postRepository,
    categoryRepository: categoryRepository,
  );
}
