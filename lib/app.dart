import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_school_information/provider/intl_provider.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'common/themes/theme_styles.dart';
import 'pages/main_page.dart';
import 'pages/onborading_page.dart';
import 'provider/theme_provider.dart';
import 'generated/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('common_box');
    // box.clear();
    bool seen = box.get('seen') ?? false;
    return Consumer2(
      builder: (_, ThemeProvider provider, IntlProvider intl, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hong Kong School Information',
          theme: light(context),
          darkTheme: dark(context),
          themeMode: provider.theme,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: intl.locale,
          home: seen ? const MainPage() : const OnBoardingPage(),
        );
      },
    );
  }
}
