import 'package:flutter/material.dart';
import 'package:takeout/navigation/app_navigation.dart';
import 'package:takeout/pages/landing/landing_page.dart';
import 'package:takeout/providers/language_provider.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: MaterialApp(
        home: AppNavigation(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: AppColors.appbarBackground),
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            primary: AppColors.primary,
            seedColor: AppColors.primary,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
    ),
  );
}
