import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';
import 'package:takeout/app.dart';
import 'package:takeout/data/datasource/local/category_local.dart';
import 'package:takeout/data/datasource/local/product_local.dart';
import 'package:takeout/data/datasource/remote/category_remote.dart';
import 'package:takeout/data/datasource/remote/product_remote.dart';
import 'package:takeout/data/datasource/remote/user_remote.dart';
import 'package:takeout/data/models/category_model.dart';
import 'package:takeout/data/models/product_model.dart';
import 'package:takeout/data/models/user_model.dart';
import 'package:takeout/data/repositories/category_repository.dart';
import 'package:takeout/data/repositories/product_repository.dart';
import 'package:takeout/data/repositories/user_repository.dart';

Future<Widget> initializeApp() async {
  // Initialize Hive
  await Hive.initFlutter();

  // await Hive.deleteBoxFromDisk('productBox');
  // await Hive.deleteBoxFromDisk('categoryBox');
  // await Hive.deleteBoxFromDisk('user');

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(ProductImageModelAdapter());
  final authBox = await Hive.openBox<UserModel>('authBox');
  final categoryBox = await Hive.openBox<CategoryModel>('categoryBox');
  final productBox = await Hive.openBox<ProductModel>('productBox');

  // Create repositories
  final userRepository = UserRepository(
    remote: UserRemoteDataSource(Dio()),
    box: authBox,
  );
  final categoryRepository = CategoryRepository(
    remote: CategoryRemoteDataSource(Dio()),
    local: CategoryLocalDataSource(categoryBox),
  );
  final productRepository = ProductRepository(
    remote: ProductRemoteDataSource(Dio()),
    local: ProductLocalDataSource(productBox),
  );
  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  return MyApp(
    userRepository: userRepository,
    categoryRepository: categoryRepository,
    productRepository: productRepository,
  );
}
