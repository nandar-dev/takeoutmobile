import 'package:flutter/material.dart';
import 'package:takeout/pages/category/categories_list.dart';
import 'package:takeout/pages/home/home_page.dart';
import 'package:takeout/pages/landing/landing_page.dart';
import 'package:takeout/pages/product/product_list.dart';
import 'package:takeout/pages/profile/profile_page.dart';

class AppRoutes {
  static const String landing = '/';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String categories = '/categories-list';
  static const String products = '/products-list';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landing:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case categories:
        return MaterialPageRoute(builder: (_) => const CategoriesList());
      case products:
        final args = settings.arguments as Map<String, dynamic>;
        final categoryId = args['categoryId'];
        return MaterialPageRoute(
          builder: (_) => ProductList(categoryId: categoryId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
