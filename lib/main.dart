import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_school_information/provider/intl_provider.dart';
import 'package:flutter_school_information/provider/theme_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'common/utils/hive_utils.dart';

void main() {
  // * make sure widgets is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // * prevent device orientation changes and force portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    // * init database
    await Hive.initFlutter();
    await Hive.openBox('common_box');
    // * register hive custom model adapter
    await HiveUtils.registerAdapter();

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => IntlProvider()),
        ],
        child: Phoenix(
          child: const MyApp(),
        ),
      ),
    );
  });
}
