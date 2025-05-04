import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/bloc/cart/bloc.dart';
import 'package:takeout/bloc/cart/event.dart';
import 'package:takeout/bloc/language/bloc.dart';
import 'package:takeout/bloc/language/state.dart';
import 'package:takeout/bloc/product_filters/bloc.dart';
import 'package:takeout/cubit/category/category_cubit.dart';
import 'package:takeout/cubit/product/product_cubit.dart';
import 'package:takeout/cubit/shoptype/shoptype_cubit.dart';
import 'package:takeout/cubit/user/user_cubit.dart';
import 'package:takeout/data/repositories/category_repository.dart';
import 'package:takeout/data/repositories/product_repository.dart';
import 'package:takeout/data/repositories/shoptype_repository.dart';
import 'package:takeout/data/repositories/user_repository.dart';
import 'package:takeout/pages/auth/auth_gate.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/services/cart_service.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;
  final ShoptypeRepository shoptypeRepository;

  const MyApp({
    super.key,
    required this.userRepository,
    required this.categoryRepository,
    required this.productRepository,
    required this.shoptypeRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FilterBloc()),
        BlocProvider(create: (_) => LanguageBloc()),
        BlocProvider(create: (_) => CartBloc(CartService())..add(LoadCart())),
        BlocProvider(create: (_) => UserCubit(userRepository)..checkAuth()),
        BlocProvider(create: (_) => CategoryCubit(categoryRepository)),
        BlocProvider(create: (_) => ProductCubit(productRepository)),
        BlocProvider(create: (_) => ShoptypeCubit(shoptypeRepository)),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, locale) {
          context.setLocale(Locale(locale.selectedLanguageId));
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AuthGate(),
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
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        },
      ),
    );
  }
}
