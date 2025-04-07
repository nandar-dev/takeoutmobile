import 'package:flutter/material.dart';
import 'package:takeout/pages/landing/landing_page.dart';
import 'package:takeout/utils/colors.dart';

void main() {
  runApp(
    MaterialApp(
      home: LandingPage(),
      theme: ThemeData(
        // colorScheme: ColorScheme(
        //   brightness: Brightness.light,
        //   primary: AppColors.primary, // Your main brand color
        //   onPrimary: Colors.white, // Text/icon color on primary
        //   secondary: Colors.blue, // Accent color (optional)
        //   onSecondary: Colors.white,
        //   error: Colors.red,
        //   onError: Colors.white,
        //   surface: Colors.white, // Card, dialog backgrounds
        //   onSurface: AppColors.black, // Text/icon on surface
        // ),
        colorScheme: ColorScheme.fromSeed(
          primary: AppColors.primary,
          seedColor: AppColors.primary,
        ),
        // CheckBox Theme
        // checkboxTheme: CheckboxThemeData(
        //   fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        //     if (states.contains(MaterialState.selected)) {
        //       return AppColors.primary; // Custom selected color
        //     }
        //     return AppColors.grey; // Unselected color (optional)
        //   }),
        // ),
        // Texfield Theme
        // inputDecorationTheme: InputDecorationTheme(
        //   focusedBorder: const OutlineInputBorder(
        //     borderSide: BorderSide(color: AppColors.primary),
        //   ),
        // ),
      ),
    ),
  );
}
