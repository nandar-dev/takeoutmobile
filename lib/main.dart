import 'package:flutter/material.dart';
import 'package:takeout/init.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final app = await initializeApp();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('zh')],
      path: 'assets/l10n',
      fallbackLocale: const Locale('en'),
      child: app,
    ),
  );
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:takeout/data/datasource/local/post_local.dart';
// import 'package:takeout/data/datasource/remote/post_remote.dart';
// import 'package:takeout/data/models/post_model.dart';
// import 'package:takeout/data/repositories/post_repository.dart';
// import 'package:takeout/bloc/post/bloc.dart';
// import 'package:takeout/bloc/post/event.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   Hive.registerAdapter(PostModelAdapter());
//   final postsBox = await Hive.openBox<PostModel>('postsBox');

//   final postRepository = PostRepository(
//     remoteDataSource: PostRemoteDataSource(http.Client()),
//     localDataSource: PostLocalDataSource(postsBox),
//   );

//   runApp(MyApp(postRepository: postRepository));
// }

// class MyApp extends StatelessWidget {
//   final PostRepository postRepository;

//   const MyApp({Key? key, required this.postRepository}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hive Bloc Example',
//       home: BlocProvider(
//         create: (_) => PostBloc(postRepository)..add(FetchPosts()),
//         child: const PostPage(),
//       ),
//     );
//   }
// }
