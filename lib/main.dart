import 'package:flutter/material.dart';
import 'package:takeout/pages/landing/landing_page.dart';
import 'package:takeout/utils/colors.dart';

void main() {
  runApp(
    MaterialApp(
      home: LandingPage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: AppColors.primary,
          seedColor: AppColors.primary,
        ),
      ),
    ),
  );
}
