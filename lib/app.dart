import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/main_page.dart';
import 'provider/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, ThemeProvider provider, __) {
        return MaterialApp(
          title: 'School Information',
          theme: ThemeData(brightness: Brightness.light),
          darkTheme: ThemeData(brightness: Brightness.dark),
          themeMode: provider.getTheme(),
          home: const MainPage(),
        );
      },
    );
  }
}
