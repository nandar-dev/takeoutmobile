import 'package:flutter/material.dart';
import 'package:takeout/navigation/app_navigation.dart';
import 'package:takeout/pages/landing/landing_page.dart';
import 'package:takeout/theme/app_colors.dart';


void main() {

  runApp(
    MaterialApp(
      home: AppNavigation(),
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
