import 'package:flutter/material.dart';
import 'package:takeout/init.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final app = await initializeApp();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('zh'),
        Locale('my'),
        Locale('th'),
      ],
      path: 'assets/l10n',
      fallbackLocale: const Locale('en'),
      child: app,
    ),
  );
}
