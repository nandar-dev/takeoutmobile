import 'package:flutter/material.dart';
import 'package:takeout/pages/auth/otp_page.dart';
import 'package:takeout/pages/profile/profile_page.dart';
import 'package:takeout/theme/app_colors.dart';

void main() {
  runApp(
    MaterialApp(
      // home: LandingPage(),
      home: ProfilePage(),
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
