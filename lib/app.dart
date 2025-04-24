import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takeout/bloc/auth/bloc.dart';
import 'package:takeout/bloc/cart/bloc.dart';
import 'package:takeout/bloc/cart/event.dart';
import 'package:takeout/bloc/language/bloc.dart';
import 'package:takeout/bloc/language/state.dart';
import 'package:takeout/bloc/product_filters/bloc.dart';
import 'package:takeout/cubit/post_cubit.dart';
import 'package:takeout/data/repositories/auth_repository.dart';
import 'package:takeout/data/repositories/post_repository.dart';
import 'package:takeout/pages/routing/routes.dart';
import 'package:takeout/services/cart_service.dart';
import 'package:takeout/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final PostRepository postRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.postRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FilterBloc()),
        BlocProvider(create: (_) => LanguageBloc()),
        BlocProvider(create: (_) => CartBloc(CartService())..add(LoadCart())),
        BlocProvider(create: (_) => PostCubit(postRepository)..loadPosts()),
        BlocProvider(create: (_) => AuthBloc(authRepository)),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, locale) {
          context.setLocale(Locale(locale.selectedLanguageId));
          return MaterialApp(
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
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        },
      ),
    );
  }
}
