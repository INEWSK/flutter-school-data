import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class IntlProvider extends ChangeNotifier {
  var box = Hive.box('common_box');

  Locale get locale {
    final String language = box.get('language') ?? Platform.localeName;
    final Locale locale;

    switch (language) {
      case 'en':
        locale = const Locale('en');
        break;
      case 'zh':
        locale = const Locale('zh', 'HK');
        break;
      default:
        // 如果系統語言開頭是 zh 一律繁體
        if (Platform.localeName.startsWith('zh')) {
          locale = const Locale('zh', 'HK');
        } else {
          locale = const Locale('en');
        }
    }
    return locale;
  }

  String get language {
    return box.get('language') ?? Platform.localeName;
  }

  void setLocale({required String language}) async {
    box.put('language', language);
    notifyListeners();
    // * restart app
    // Phoenix.rebirth(context);
  }
}
