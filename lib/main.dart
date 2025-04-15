import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/bloc/product_filters/bloc.dart';
import 'package:takeout/bloc/language/bloc.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FilterBloc()),
        BlocProvider(create: (_) => LanguageBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.landing,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.appbarBackground,
          ),
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
          ),
          canvasColor: AppColors.neutral10,
        ),
      ),
    );
  }
}
