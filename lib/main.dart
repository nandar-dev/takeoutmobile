// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:takeout/bloc/cart/bloc.dart';
// import 'package:takeout/bloc/cart/event.dart';
// import 'package:takeout/bloc/language/state.dart';
// import 'package:takeout/bloc/product_filters/bloc.dart';
// import 'package:takeout/bloc/language/bloc.dart';
// import 'package:takeout/data/models/post_model.dart';
// import 'package:takeout/pages/routing/routes.dart';
// import 'package:takeout/services/cart_service.dart';
// import 'package:takeout/theme/app_colors.dart';
// import 'package:easy_localization/easy_localization.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//  await Hive.initFlutter();
//   Hive.registerAdapter(PostModelAdapter());
//   // final postsBox = await Hive.openBox<PostModel>('postsBox');

//   // final postRepository = PostRepository(
//   //   remoteDataSource: PostRemoteDataSource(http.Client()),
//   //   localDataSource: PostLocalDataSource(postsBox),
//   // );

//   await EasyLocalization.ensureInitialized();
//   runApp(
//     EasyLocalization(
//       supportedLocales: [Locale('en'), Locale('zh')],
//       path: 'assets/l10n',
//       fallbackLocale: Locale('en'),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => FilterBloc()),
//         BlocProvider(create: (_) => LanguageBloc()),
//         BlocProvider(create: (_) => CartBloc(CartService())..add(LoadCart())),
//       ],
//       child: BlocBuilder<LanguageBloc, LanguageState>(
//         builder: (context, locale) {
//           context.setLocale(Locale(locale.selectedLanguageId));
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             initialRoute: AppRoutes.landing,
//             onGenerateRoute: AppRoutes.onGenerateRoute,
//             theme: ThemeData(
//               appBarTheme: const AppBarTheme(
//                 backgroundColor: AppColors.appbarBackground,
//               ),
//               scaffoldBackgroundColor: AppColors.background,
//               colorScheme: ColorScheme.fromSeed(
//                 seedColor: AppColors.primary,
//                 primary: AppColors.primary,
//               ),
//               canvasColor: AppColors.neutral10,
//             ),
//             localizationsDelegates: context.localizationDelegates,
//             supportedLocales: context.supportedLocales,
//             locale: context.locale,
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:takeout/bloc/post/bloc.dart';
import 'package:takeout/bloc/post/event.dart';
import 'package:takeout/bloc/post/state.dart';
import 'package:takeout/data/datasource/local/post_local.dart';
import 'package:takeout/data/datasource/remote/post_remote.dart';
import 'package:takeout/data/models/post_model.dart';
import 'package:takeout/data/repositories/post_repository.dart';

 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PostModelAdapter());
  final postsBox = await Hive.openBox<PostModel>('postsBox');

  final postRepository = PostRepository(
    remoteDataSource: PostRemoteDataSource(http.Client()),
    localDataSource: PostLocalDataSource(postsBox),
  );

  runApp(MyApp(postRepository: postRepository));
}

class MyApp extends StatelessWidget {
  final PostRepository postRepository;

  const MyApp({Key? key, required this.postRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Bloc Example',
      home: BlocProvider(
        create: (_) => PostBloc(postRepository)..add(FetchPosts()),
        child: PostPage(),
      ),
    );
  }
}

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cached Posts')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (_, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(post.title ?? ''),
                  subtitle: Text(post.body ?? ''),
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Press the button to fetch posts.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PostBloc>().add(FetchPosts());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
