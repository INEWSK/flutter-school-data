import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'common/themes/theme_styles.dart';
import 'pages/main_page.dart';
import 'pages/onborading_page.dart';
import 'provider/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('common_box');
    // box.clear();
    bool seen = box.get('seen') ?? false;
    return Consumer<ThemeProvider>(
      builder: (_, ThemeProvider provider, __) {
        return MaterialApp(
          title: 'School Information',
          theme: light(context),
          darkTheme: dark(context),
          themeMode: provider.getTheme(),
          home: seen ? const MainPage() : const OnBoardingPage(),
        );
      },
    );
  }
}
