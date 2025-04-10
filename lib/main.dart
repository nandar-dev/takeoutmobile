import 'package:flutter/material.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: AppRoutes.landing,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: AppColors.appbarBackground),
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          primary: AppColors.primary,
          seedColor: AppColors.primary,
        ),
      ),
    ),
  );
}
